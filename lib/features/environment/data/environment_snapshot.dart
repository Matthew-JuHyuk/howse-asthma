/// Client model for Edge `calculate-environment-risk` response.
class EnvironmentSnapshot {
  const EnvironmentSnapshot({
    required this.riskScore,
    required this.uiState,
    required this.triggers,
    this.geohash,
    this.aqiEpa,
    this.aqiSource,
    this.pm25,
    this.localPm25,
    this.trapLevel,
    this.trapNearFreightWeight = false,
    this.pollenUpi,
    this.dominantPollenType,
    this.hasFlashFloodWarning = false,
    this.floodAlertHeadline,
    this.usgsStreamRateFtHr,
    this.dataSourceSummary,
    this.sourceCoverage,
    this.forecastPoints = const [],
    this.fromCache = false,
    this.fromStaleCache = false,
    this.degraded = false,
    this.pollenFetchedAt,
    this.forecastId,
  });

  final int riskScore;
  final String uiState;
  final Map<String, bool> triggers;
  final String? geohash;
  final int? aqiEpa;
  final String? aqiSource;
  final double? pm25;
  final double? localPm25;
  final String? trapLevel;
  final bool trapNearFreightWeight;
  final int? pollenUpi;
  final String? dominantPollenType;
  final bool hasFlashFloodWarning;
  final String? floodAlertHeadline;
  final double? usgsStreamRateFtHr;
  final Map<String, String>? dataSourceSummary;
  final Map<String, SourceCoverage>? sourceCoverage;
  final List<ForecastDayPoint> forecastPoints;
  final bool fromCache;
  final bool fromStaleCache;
  final bool degraded;
  final String? pollenFetchedAt;
  final String? forecastId;

  bool get isWarningOrAbove =>
      uiState == 'WARNING' ||
      uiState == 'EMERGENCY' ||
      riskScore >= 3;

  bool get showNjOnlyFreightNotice {
    final njdot = sourceCoverage?['njdot'];
    if (njdot == null) return false;
    return njdot.scope == 'NJ_ONLY' && !njdot.applied;
  }

  factory EnvironmentSnapshot.fromJson(Map<String, dynamic> json) {
    final triggersRaw = json['triggers'];
    final triggers = <String, bool>{};
    if (triggersRaw is Map) {
      for (final e in triggersRaw.entries) {
        triggers[e.key.toString()] = e.value == true;
      }
    }

    final summaryRaw = json['data_source_summary'];
    Map<String, String>? summary;
    if (summaryRaw is Map) {
      summary = summaryRaw.map(
        (k, v) => MapEntry(k.toString(), v.toString()),
      );
    }

    final coverageRaw = json['source_coverage'];
    Map<String, SourceCoverage>? coverage;
    if (coverageRaw is Map) {
      coverage = {};
      for (final e in coverageRaw.entries) {
        if (e.value is Map) {
          coverage[e.key.toString()] = SourceCoverage.fromJson(
            Map<String, dynamic>.from(e.value as Map),
          );
        }
      }
    }

    final pointsRaw = json['forecast_points'];
    final points = <ForecastDayPoint>[];
    if (pointsRaw is List) {
      for (final p in pointsRaw) {
        if (p is Map) {
          points.add(ForecastDayPoint.fromJson(Map<String, dynamic>.from(p)));
        }
      }
    }

    return EnvironmentSnapshot(
      riskScore: (json['risk_score'] as num?)?.toInt() ?? 1,
      uiState: json['ui_state'] as String? ?? 'CALM',
      triggers: triggers,
      geohash: json['geohash'] as String?,
      aqiEpa: (json['aqi_epa'] as num?)?.toInt(),
      aqiSource: json['aqi_source'] as String?,
      pm25: (json['pm25'] as num?)?.toDouble(),
      localPm25: (json['local_pm25'] as num?)?.toDouble(),
      trapLevel: json['trap_level'] as String?,
      trapNearFreightWeight: json['trap_near_freight_weight'] == true,
      pollenUpi: (json['pollen_upi'] as num?)?.toInt(),
      dominantPollenType: json['dominant_pollen_type'] as String?,
      hasFlashFloodWarning: json['has_flash_flood_warning'] == true,
      floodAlertHeadline: json['flood_alert_headline'] as String?,
      usgsStreamRateFtHr: (json['usgs_stream_rate_ft_hr'] as num?)?.toDouble(),
      dataSourceSummary: summary,
      sourceCoverage: coverage,
      forecastPoints: points,
      fromCache: json['from_cache'] == true,
      fromStaleCache: json['from_stale_cache'] == true,
      degraded: json['degraded'] == true,
      pollenFetchedAt: json['pollen_fetched_at'] as String?,
      forecastId: json['forecast_id'] as String? ?? json['id'] as String?,
    );
  }
}

class ForecastDayPoint {
  const ForecastDayPoint({
    required this.date,
    required this.periods,
    this.pollenUpi,
    this.dominantPollenType,
    this.usAqiMax,
    this.compositeScore,
  });

  final String date;
  final List<ForecastPeriodPoint> periods;
  final int? pollenUpi;
  final String? dominantPollenType;
  final int? usAqiMax;
  final int? compositeScore;

  factory ForecastDayPoint.fromJson(Map<String, dynamic> json) {
    final periodsRaw = json['periods'];
    final periods = <ForecastPeriodPoint>[];
    if (periodsRaw is List) {
      for (final p in periodsRaw) {
        if (p is Map) {
          periods.add(
            ForecastPeriodPoint.fromJson(Map<String, dynamic>.from(p)),
          );
        }
      }
    }
    return ForecastDayPoint(
      date: json['date'] as String? ?? '',
      periods: periods,
      pollenUpi: (json['pollen_upi'] as num?)?.toInt(),
      dominantPollenType: json['dominant_pollen_type'] as String?,
      usAqiMax: (json['us_aqi_max'] as num?)?.toInt(),
      compositeScore: (json['composite_score'] as num?)?.toInt(),
    );
  }
}

class ForecastPeriodPoint {
  const ForecastPeriodPoint({
    required this.period,
    this.usAqi,
    this.pollenUpi,
    this.trapLevel,
    this.floodActive = false,
  });

  final String period;
  final int? usAqi;
  final int? pollenUpi;
  final String? trapLevel;
  final bool floodActive;

  factory ForecastPeriodPoint.fromJson(Map<String, dynamic> json) {
    return ForecastPeriodPoint(
      period: json['period'] as String? ?? 'morning',
      usAqi: (json['us_aqi'] as num?)?.toInt(),
      pollenUpi: (json['pollen_upi'] as num?)?.toInt(),
      trapLevel: json['trap_level'] as String?,
      floodActive: json['flood_active'] == true,
    );
  }
}

class SourceCoverage {
  const SourceCoverage({
    required this.scope,
    required this.applied,
    this.reason,
  });

  final String scope;
  final bool applied;
  final String? reason;

  factory SourceCoverage.fromJson(Map<String, dynamic> json) {
    return SourceCoverage(
      scope: json['scope'] as String? ?? 'UNKNOWN',
      applied: json['applied'] == true,
      reason: json['reason'] as String?,
    );
  }
}
