import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Dashboard tab: shows local weather / air quality and the current
/// asthma-attack risk level for the user.
///
/// TODO: wire up a real weather + air-quality API (e.g. OpenWeather /
/// IQAir) using the device location (geolocator) and compute a risk
/// score based on pollen, PM2.5/PM10, humidity and temperature swings.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('${l10n.homeGreeting} 👋', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          _RiskBanner(label: l10n.asthmaRiskLow),
          const SizedBox(height: 16),
          _InfoCard(title: l10n.homeWeatherTitle, placeholder: '--°C'),
          const SizedBox(height: 12),
          _InfoCard(title: l10n.homeAirQualityTitle, placeholder: 'AQI --'),
        ],
      ),
    );
  }
}

class _RiskBanner extends StatelessWidget {
  const _RiskBanner({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.health_and_safety, color: scheme.onPrimaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: scheme.onPrimaryContainer)),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.placeholder});

  final String title;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(placeholder, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
