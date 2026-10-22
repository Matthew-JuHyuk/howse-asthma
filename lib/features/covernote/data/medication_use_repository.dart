import '../../../core/supabase/supabase_service.dart';
import '../../assessments/data/pdc_repository.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../records/data/regimen_repository.dart';
import '../../records/domain/record_models.dart';
import '../../records/data/records_revision.dart';
import '../domain/record_snapshot.dart';
import '../domain/s9_models.dart';

/// Unified list: new `medication_use_events` plus adapters for inhaler,
/// occasion checks, and daily PDC. Nothing is deleted as a "duplicate".
class MedicationUseRepository {
  Future<List<MedicationUseEvent>> listBetween(DayRange range) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return const [];

    final from = isoDate(range.from);
    final to = isoDate(range.to);
    final collected = <MedicationUseEvent>[];
    final seen = <String>{};

    void add(MedicationUseEvent e) {
      if (e.undone) return;
      if (seen.contains(e.id)) return;
      if (e.sourceId != null && seen.contains('${e.sourceTable}:${e.sourceId}')) {
        return;
      }
      seen.add(e.id);
      if (e.sourceId != null) seen.add('${e.sourceTable}:${e.sourceId}');
      collected.add(e);
    }

    try {
      final rows = await SupabaseService.client
          .from('medication_use_events')
          .select()
          .eq('patient_id', uid)
          .gte('local_date', from)
          .lte('local_date', to)
          .isFilter('undone_at', null);
      for (final r in rows as List) {
        add(MedicationUseEvent.fromRow(r as Map));
      }
    } catch (_) {
      // Table may not exist yet on an old backend; adapters still run.
    }

    try {
      final inhaler = await InhalerEventRepository().listBetween(
        range.from,
        range.to,
      );
      for (final e in inhaler) {
        if (e.isPanic) continue;
        add(
          MedicationUseEvent(
            id: 'inhaler:${e.id}',
            useKind: UseKind.asNeeded,
            occurredAt: e.recordedAtUtc,
            localDate: e.localDate,
            medicationName: e.medicationLabel,
            quantity: e.puffCount?.toDouble(),
            unit: e.puffCount != null ? 'puff' : null,
            inputPath: 'inhaler_events',
            sourceTable: 'inhaler_events',
            sourceId: e.id,
          ),
        );
      }
    } catch (_) {}

    try {
      final checks = await RegimenRepository().listBetween(range.from, range.to);
      for (final c in checks) {
        if (c.status != 'used') continue;
        add(
          MedicationUseEvent(
            id: 'occasion:${c.id}',
            useKind: UseKind.scheduled,
            occurredAt: DateTime(
              c.localDate.year,
              c.localDate.month,
              c.localDate.day,
              12,
            ).toUtc(),
            localDate: c.localDate,
            scheduledInstanceId: c.id,
            inputPath: 'occasion',
            sourceTable: 'medication_occasion_checks',
            sourceId: c.id,
          ),
        );
      }
    } catch (_) {}

    try {
      final pdc = await PdcRepository().listBetween(range.from, range.to);
      for (final p in pdc) {
        if (p.status != MedCheckRecord.used) continue;
        add(
          MedicationUseEvent(
            id: 'pdc:${p.id}',
            useKind: UseKind.scheduled,
            occurredAt: DateTime(p.date.year, p.date.month, p.date.day, 12)
                .toUtc(),
            localDate: p.date,
            inputPath: 'daily_check',
            sourceTable: 'pdc_daily_checks',
            sourceId: p.id,
          ),
        );
      }
    } catch (_) {}

    collected.sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return collected;
  }

  Future<MedicationUseEvent> log({
    required UseKind kind,
    required DateTime occurredAt,
    String? medicationId,
    String? medicationName,
    double? quantity,
    String? unit,
    String? scheduledInstanceId,
    String? inputPath,
    String? clientRequestId,
  }) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) throw StateError('not_signed_in');
    final local = occurredAt.toLocal();
    final localDate = DateTime(local.year, local.month, local.day);
    final row = await SupabaseService.client
        .from('medication_use_events')
        .insert({
          'patient_id': uid,
          'medication_id': medicationId,
          'medication_name': medicationName,
          'use_kind': useKindSql(kind),
          'occurred_at': occurredAt.toUtc().toIso8601String(),
          'local_date': isoDate(localDate),
          'timezone': local.timeZoneName,
          'tz_offset_minutes': local.timeZoneOffset.inMinutes,
          'quantity': quantity,
          'unit': unit,
          'scheduled_instance_id': scheduledInstanceId,
          'input_path': inputPath ?? 'records',
          'sync_status': 'synced',
          'client_request_id': clientRequestId ?? newRequestId(),
          'env_status': 'pending',
        })
        .select()
        .single();
    RecordsRevision.instance.bump();
    return MedicationUseEvent.fromRow(row);
  }

  Future<void> undo(MedicationUseEvent event) async {
    if (event.sourceTable == 'inhaler_events' && event.sourceId != null) {
      await InhalerEventRepository().voidEvent(event.sourceId!);
      RecordsRevision.instance.bump();
      return;
    }
    if (event.sourceTable == 'pdc_daily_checks' && event.sourceId != null) {
      await PdcRepository().delete(event.sourceId!);
      RecordsRevision.instance.bump();
      return;
    }
    if (event.id.startsWith('inhaler:') ||
        event.id.startsWith('pdc:') ||
        event.id.startsWith('occasion:')) {
      return;
    }
    await SupabaseService.client
        .from('medication_use_events')
        .update({'undone_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', event.id);
    RecordsRevision.instance.bump();
  }

  Future<void> markEnv(String id, String status) async {
    if (id.contains(':')) return;
    try {
      await SupabaseService.client
          .from('medication_use_events')
          .update({'env_status': status})
          .eq('id', id);
    } catch (_) {}
  }
}
