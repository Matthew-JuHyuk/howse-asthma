import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/location/location_service.dart';
import '../../../core/phone/phone_e164.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../records/data/records_revision.dart';
import '../../records/domain/record_models.dart';
import '../../settings/data/emergency_contact_repository.dart';
import '../data/panic_repository.dart';

/// Urgent help (internal id SCR-SYS-PANIC). Phone buttons only open the OS
/// dialer — nothing is dialed or sent automatically, and environment data
/// never decides whether this is an emergency.
class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  final _panicRepo = PanicRepository();
  final _inhalerRepo = InhalerEventRepository();
  final _contactRepo = EmergencyContactRepository();
  final _location = const LocationService();
  final _inhalerRequestId = newRequestId();

  String? _episodeId;
  String? _contactPhone;
  String? _contactName;
  bool _busy = false;
  bool _logged = false;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    if (!_completed && _episodeId != null) {
      _panicRepo.complete(episodeId: _episodeId!, outcomeChip: 'dismissed');
    }
    super.dispose();
  }

  Future<void> _bootstrap() async {
    try {
      final contact = await _contactRepo.get();
      if (mounted) {
        setState(() {
          final phone = contact?['phone_e164'] as String?;
          _contactPhone = phone != null && PhoneE164.isValid(phone)
              ? phone
              : null;
          _contactName = contact?['display_name'] as String?;
        });
      }
    } catch (_) {}
    try {
      final episode = await _panicRepo.startEpisode();
      if (mounted) setState(() => _episodeId = episode['id'] as String?);
    } catch (_) {}
  }

  Future<void> _logInhaler() async {
    if (_busy || _logged) return;
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    setState(() => _busy = true);
    try {
      final loc = await _location.getCurrentPosition(requestIfDenied: false);
      final event = await _inhalerRepo.logUse(
        latitude: loc.position?.latitude,
        longitude: loc.position?.longitude,
        isPanic: true,
        clientRequestId: _inhalerRequestId,
        sourceLanguage: lang,
      );
      RecordsRevision.instance.bump();
      final eventId = event['id'] as String?;
      if (_episodeId != null && eventId != null) {
        await _panicRepo.linkInhalerEvent(
          episodeId: _episodeId!,
          inhalerEventId: eventId,
        );
      }
      if (!mounted) return;
      setState(() => _logged = true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.s5InhalerLogged)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.s5SaveFailed)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _dial(String raw) async {
    final l10n = AppLocalizations.of(context)!;
    final number = raw == '911' ? '911' : PhoneE164.normalize(raw);
    if (number == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.panicDialFailed)));
      return;
    }
    final ok = await launchUrl(
      Uri.parse('tel:$number'),
      mode: LaunchMode.externalApplication,
    );
    if (!ok && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.panicDialFailed)));
      return;
    }
    if (_episodeId != null) {
      try {
        await _panicRepo.markHelpRequested(_episodeId!);
      } catch (_) {}
    }
  }

  Future<void> _close(String outcome) async {
    if (_episodeId != null) {
      try {
        await _panicRepo.complete(episodeId: _episodeId!, outcomeChip: outcome);
      } catch (_) {}
    }
    _completed = true;
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasContact = _contactPhone != null;
    final contactLabel = (_contactName == null || _contactName!.isEmpty)
        ? l10n.mockCallGuardian
        : l10n.panicCallNamed(_contactName!);

    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop && !_completed && _episodeId != null) {
          _completed = true;
          try {
            await _panicRepo.complete(
              episodeId: _episodeId!,
              outcomeChip: 'dismissed',
            );
          } catch (_) {}
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.defaultBackground,
        appBar: AppBar(title: Text(l10n.s5UrgentHelp)),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              Text(
                l10n.s5UrgentIntro,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.s5UrgentActionPlan,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.error600,
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () => _dial('911'),
                icon: const Icon(Icons.call),
                label: Text(l10n.mockCall911),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: hasContact ? () => _dial(_contactPhone!) : null,
                icon: const Icon(Icons.person_outline),
                label: Text(contactLabel, textAlign: TextAlign.center),
              ),
              if (!hasContact) ...[
                const SizedBox(height: 6),
                Text(
                  l10n.s5UrgentNoContact,
                  style: const TextStyle(color: AppTheme.neutral700),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                l10n.panicNoAutoDial,
                style: const TextStyle(color: AppTheme.neutral700),
              ),
              const Divider(height: 32),
              Text(
                l10n.s5UrgentLogHint,
                style: const TextStyle(color: AppTheme.neutral700),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: _busy || _logged ? null : _logInhaler,
                icon: Icon(_logged ? Icons.check : Icons.medication_outlined),
                label: Text(_logged ? l10n.s5InhalerLogged : l10n.s5LogInhaler),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _close('feeling_better'),
                child: Text(l10n.mockFeelingBetter),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
