import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../features/records/data/records_revision.dart';
import '../../features/records/data/regimen_repository.dart';
import '../../features/records/domain/record_models.dart';
import '../../l10n/app_localizations.dart';

/// Local reminders at the times on the patient's saved prescription.
/// This is not the 30-minute environment push. No response is stored as missed.
class MedicationReminder {
  MedicationReminder._();
  static final instance = MedicationReminder._();

  static const _hideKey = 's6_hide_med_name';
  static const _channelId = 'medication_occasion';
  static const _idBase = 21000;
  static const _idCount = 48;

  final _plugin = FlutterLocalNotificationsPlugin();
  var _ready = false;
  var _tzReady = false;

  Future<bool> hideMedicationName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hideKey) ?? true;
  }

  Future<void> setHideMedicationName(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hideKey, value);
  }

  Future<void> ensureInitialized() async {
    if (_ready) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: darwin),
      onDidReceiveNotificationResponse: _onResponse,
    );
    _ready = true;
    final launch = await _plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      await _apply(launch!.notificationResponse);
    }
  }

  Future<void> reschedule(
    AppLocalizations l10n,
    List<MedicationRegimen> regimens,
    List<OccasionCheck> checks,
  ) async {
    try {
      await ensureInitialized();
      await _ensureTz();
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await android?.requestNotificationsPermission();
      for (var i = 0; i < _idCount; i++) {
        await _plugin.cancel(id: _idBase + i);
      }
      final hide = await hideMedicationName();
      final now = tz.TZDateTime.now(tz.local);
      var slot = 0;
      for (final regimen in regimens.where((r) => r.schedulesReminders)) {
        for (var day = 0; day < 2 && slot < _idCount; day++) {
          final date = DateTime(now.year, now.month, now.day + day);
          if (!regimen.covers(date)) continue;
          for (var index = 0; index < regimen.timesMinutes.length; index++) {
            if (slot >= _idCount) break;
            final answered = checks.any(
              (c) =>
                  c.regimenId == regimen.id &&
                  c.localDate == dateOnly(date) &&
                  c.occasionIndex == index,
            );
            if (answered) continue;
            final minutes = regimen.timesMinutes[index];
            final when = tz.TZDateTime(
              tz.local,
              date.year,
              date.month,
              date.day,
              minutes ~/ 60,
              minutes % 60,
            );
            if (!when.isAfter(now)) continue;
            final name = regimen.medicationName ?? '';
            final payload = jsonEncode({
              'regimenId': regimen.id,
              'date': isoDate(date),
              'index': index,
            });
            await _plugin.zonedSchedule(
              id: _idBase + slot,
              scheduledDate: when,
              androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
              title: l10n.s6ReminderTitle,
              body: hide || name.isEmpty
                  ? l10n.s6ReminderBodyPrivate
                  : l10n.s6ReminderBodyNamed(name),
              payload: payload,
              notificationDetails: NotificationDetails(
                android: AndroidNotificationDetails(
                  _channelId,
                  l10n.s6ReminderTitle,
                  channelDescription: l10n.s6ReminderChannel,
                  visibility: hide
                      ? NotificationVisibility.private
                      : NotificationVisibility.public,
                  actions: [
                    AndroidNotificationAction(
                      'used',
                      l10n.s6DoseUsed,
                      showsUserInterface: true,
                    ),
                    AndroidNotificationAction(
                      'deferred',
                      l10n.s6DoseLater,
                      showsUserInterface: true,
                    ),
                    AndroidNotificationAction(
                      'not_used',
                      l10n.s6DoseNotUsed,
                      showsUserInterface: true,
                    ),
                  ],
                ),
                iOS: const DarwinNotificationDetails(),
              ),
            );
            slot++;
          }
        }
      }
    } catch (e) {
      debugPrint('medication reminder schedule skipped: $e');
    }
  }

  Future<void> _ensureTz() async {
    if (_tzReady) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }
    _tzReady = true;
  }

  static void _onResponse(NotificationResponse response) {
    instance._apply(response);
  }

  Future<void> _apply(NotificationResponse? response) async {
    final action = response?.actionId;
    final raw = response?.payload;
    if (action == null || raw == null) return;
    if (action != 'used' && action != 'not_used' && action != 'deferred') {
      return;
    }
    try {
      final json = jsonDecode(raw);
      if (json is! Map) return;
      final regimenId = json['regimenId'];
      final date = json['date'];
      final index = json['index'];
      if (regimenId is! String || date is! String || index is! int) return;
      final parsed = DateTime.tryParse(date);
      if (parsed == null) return;
      await RegimenRepository().respond(
        regimenId: regimenId,
        localDate: parsed,
        occasionIndex: index,
        status: action,
        requestId: newRequestId(),
        source: 'notification',
      );
      RecordsRevision.instance.bump();
    } catch (e) {
      debugPrint('medication reminder action skipped: $e');
    }
  }
}
