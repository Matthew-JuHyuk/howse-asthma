import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../data/environment_snapshot.dart';

enum EnvItemStatus { latest, older, unavailable }

/// Plain-language environment wording shared by Home and the Environment tab.
/// Categories come from each provider's published scale; the app's internal
/// composite score is never shown as an asthma risk.
class EnvLabels {
  EnvLabels._();

  /// U.S. EPA AQI categories.
  static String aqiCategory(AppLocalizations l10n, int aqi) {
    if (aqi <= 50) return l10n.s5AqiGood;
    if (aqi <= 100) return l10n.s5AqiModerate;
    if (aqi <= 150) return l10n.s5AqiUsg;
    if (aqi <= 200) return l10n.s5AqiUnhealthy;
    if (aqi <= 300) return l10n.s5AqiVeryUnhealthy;
    return l10n.s5AqiHazardous;
  }

  /// Google Pollen API Universal Pollen Index categories (0–5).
  static String upiCategory(AppLocalizations l10n, int upi) => switch (upi) {
    <= 0 => l10n.s5UpiNone,
    1 => l10n.s5UpiVeryLow,
    2 => l10n.s5UpiLow,
    3 => l10n.s5UpiModerate,
    4 => l10n.s5UpiHigh,
    _ => l10n.s5UpiVeryHigh,
  };

  static String airQualityValue(AppLocalizations l10n, EnvironmentSnapshot s) {
    final aqi = s.aqiEpa;
    if (aqi == null) return l10n.s5EnvNotAvailable;
    return l10n.s5AqiValue(aqiCategory(l10n, aqi), aqi);
  }

  static String pollenValue(AppLocalizations l10n, EnvironmentSnapshot s) {
    final upi = s.pollenUpi;
    if (upi == null) return l10n.s5EnvNotAvailable;
    return l10n.s5UpiValue(upi, upiCategory(l10n, upi));
  }

  static String humidityValue(AppLocalizations l10n, EnvironmentSnapshot s) {
    final rh = s.moldRhPct;
    if (rh == null) return l10n.s5EnvNotAvailable;
    return l10n.s5HumidityValue(rh.round());
  }

  /// "No warnings" only when the alert source answered normally.
  static String floodValue(AppLocalizations l10n, EnvironmentSnapshot s) {
    if (s.hasFlashFloodWarning) return l10n.s5FloodIssued;
    if (s.sourceOk('nws')) return l10n.s5FloodNone;
    return l10n.s5FloodUnknown;
  }

  static EnvItemStatus status(bool hasValue, {required bool older}) {
    if (!hasValue) return EnvItemStatus.unavailable;
    return older ? EnvItemStatus.older : EnvItemStatus.latest;
  }

  static String statusLabel(AppLocalizations l10n, EnvItemStatus s) =>
      switch (s) {
        EnvItemStatus.latest => l10n.s5StatusLatest,
        EnvItemStatus.older => l10n.s5StatusOlder,
        EnvItemStatus.unavailable => l10n.s5StatusUnavailable,
      };

  /// Local date + time (never a raw UTC string).
  static String localDateTime(BuildContext context, DateTime t) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.MMMd(locale).add_jm().format(t.toLocal());
  }

  static String? localDateTimeIso(BuildContext context, String? iso) {
    if (iso == null) return null;
    final t = DateTime.tryParse(iso);
    return t == null ? null : localDateTime(context, t);
  }
}
