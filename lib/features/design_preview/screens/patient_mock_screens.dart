import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../mock_nav.dart';
import '../screen_ids.dart';
import '../widgets/mock_widgets.dart';

class PatHomeMock extends StatelessWidget {
  const PatHomeMock({super.key, required this.warning});

  final bool warning;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final id = warning ? MockScreenId.patHomeWarn : MockScreenId.patHome;

    return Column(
      children: [
        if (warning)
          Container(
            width: double.infinity,
            color: AppTheme.error500,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${l10n.mockStateWarning} — Score 3',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            children: [
              MockBrandHeader(
                title: l10n.appTitle,
                screenId: id.id,
                brandColor: warning ? AppTheme.error500 : AppTheme.brand600,
                titleColor: warning ? AppTheme.error600 : AppTheme.brand700,
                trailing: CircleAvatar(
                  backgroundColor: warning ? const Color(0xFFFEE2E2) : AppTheme.neutral100,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: warning ? AppTheme.error500 : AppTheme.neutral500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                warning ? 'Attention needed' : 'Good morning',
                style: TextStyle(
                  fontSize: warning ? 28 : 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.defaultFont,
                ),
              ),
              Text(
                warning ? 'Your risk level is elevated today' : 'Here is your daily summary',
                style: TextStyle(
                  color: warning ? AppTheme.error600 : AppTheme.subtext,
                  fontWeight: warning ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              _RiskCard(warning: warning, l10n: l10n),
              if (warning) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.error500,
                          minimumSize: const Size.fromHeight(52),
                        ),
                        onPressed: () => MockNav.push(context, MockScreenId.patLog),
                        icon: const Icon(Icons.medication_outlined),
                        label: Text(l10n.medicationLogAddButton.split('/').first.trim()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.error600,
                          side: const BorderSide(color: AppTheme.error500, width: 2),
                          minimumSize: const Size.fromHeight(52),
                        ),
                        onPressed: () => MockNav.push(context, MockScreenId.sysAlert),
                        icon: const Icon(Icons.shield_outlined),
                        label: const Text('What to Do'),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              Text(
                'Environmental Factors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: warning ? AppTheme.error600 : AppTheme.neutral700,
                ),
              ),
              const SizedBox(height: 12),
              MockFactorRow(
                icon: Icons.apartment_outlined,
                title: l10n.mockTrapAxis,
                level: warning ? 'High' : 'Low',
                detail: 'Air-quality proxy — not truck counts',
                filled: warning ? 4 : 1,
                levelColor: warning ? AppTheme.error500 : AppTheme.brand600,
                barColor: warning ? AppTheme.error500 : AppTheme.brand400,
                iconBg: warning ? const Color(0xFFFEE2E2) : AppTheme.neutral100,
                iconColor: warning ? AppTheme.error600 : AppTheme.neutral600,
                borderColor: warning ? const Color(0xFFFECACA) : AppTheme.neutral200,
                tip: warning ? 'Roadside PM elevated — limit outdoor activity' : null,
                onTap: () => MockNav.push(context, MockScreenId.patEnv),
              ),
              const SizedBox(height: 10),
              MockFactorRow(
                icon: Icons.flood_outlined,
                title: l10n.mockFloodAxis,
                level: warning ? 'Moderate' : 'None',
                detail: warning
                    ? 'Flash-flood advisory in your area'
                    : 'No flood advisory in your area',
                filled: warning ? 3 : 1,
                levelColor: warning ? AppTheme.warning600 : AppTheme.brand600,
                barColor: warning ? AppTheme.warning500 : AppTheme.brand300,
                iconBg: warning ? AppTheme.warning50 : AppTheme.brand50,
                iconColor: warning ? AppTheme.warning600 : AppTheme.brand600,
                borderColor: warning ? AppTheme.warning200 : AppTheme.neutral200,
                tip: warning ? 'Avoid low-lying roads and stay indoors' : null,
                onTap: () => MockNav.push(context, MockScreenId.patEnv),
              ),
              const SizedBox(height: 10),
              MockFactorRow(
                icon: Icons.grass_outlined,
                title: l10n.mockPollenAxis,
                level: warning ? 'High' : 'Moderate',
                detail: warning
                    ? 'Tree and grass pollen very high today'
                    : 'Tree pollen is elevated today',
                filled: warning ? 4 : 3,
                levelColor: warning ? AppTheme.error500 : AppTheme.warning600,
                barColor: warning ? AppTheme.error500 : AppTheme.warning500,
                iconBg: warning ? const Color(0xFFFEE2E2) : AppTheme.warning50,
                iconColor: warning ? AppTheme.error600 : AppTheme.warning600,
                borderColor: warning ? const Color(0xFFFECACA) : AppTheme.neutral200,
                tip: warning ? 'Close windows and keep rescue inhaler nearby' : null,
                onTap: () => MockNav.push(context, MockScreenId.patEnv),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: warning ? AppTheme.error500.withValues(alpha: 0.7) : AppTheme.neutral400,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    warning ? 'Last inhaler use: 6 hours ago' : 'Last inhaler use: 2 days ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: warning ? AppTheme.error500.withValues(alpha: 0.7) : AppTheme.neutral400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (!warning)
                OutlinedButton(
                  onPressed: () => MockNav.push(context, MockScreenId.patHomeWarn),
                  child: Text(l10n.mockShowWarningHome),
                )
              else
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.mockBackToCalmHome),
                ),
              TextButton(
                onPressed: () => MockNav.openCatalog(context),
                child: Text(l10n.mockAllScreens),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RiskCard extends StatelessWidget {
  const _RiskCard({required this.warning, required this.l10n});

  final bool warning;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: warning ? const Color(0xFFFEF2F2) : AppTheme.brand50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: warning ? const Color(0xFFFCA5A5) : AppTheme.brand200,
          width: warning ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: warning ? AppTheme.error500 : AppTheme.brand100,
            child: Icon(
              Icons.show_chart,
              color: warning ? Colors.white : AppTheme.brand600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      warning ? l10n.mockStateWarning : l10n.mockStateCalm,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: warning ? AppTheme.error600 : AppTheme.brand700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: warning ? AppTheme.error500 : AppTheme.brand600,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        warning ? 'Score 3' : 'Score 1',
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                Text(
                  warning ? 'Multiple risk factors elevated' : 'Risk level is low today',
                  style: TextStyle(
                    fontSize: 12,
                    color: warning ? AppTheme.error600 : AppTheme.brand700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: warning ? AppTheme.error500 : AppTheme.brand400,
          ),
        ],
      ),
    );
  }
}

class PatEnvMock extends StatelessWidget {
  const PatEnvMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patEnv.id,
      title: 'Environment',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.brand50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.brand200),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.brand100,
                  child: Icon(Icons.check_circle_outline, color: AppTheme.brand600),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall: Low Risk',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700),
                      ),
                      Text(
                        'Conditions are mostly favorable today',
                        style: const TextStyle(fontSize: 12, color: AppTheme.brand600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('3-Axis Risk Detail', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          MockFactorRow(
            icon: Icons.apartment_outlined,
            title: 'TRAP Air Quality',
            level: 'Low',
            detail: 'Traffic-related air pollution proxy',
            filled: 1,
            tip: 'Nearby air quality is good. Modeled proxy — not vehicle counts.',
            iconBg: AppTheme.brand50,
            iconColor: AppTheme.brand600,
          ),
          const SizedBox(height: 10),
          MockFactorRow(
            icon: Icons.flood_outlined,
            title: l10n.mockFloodAxis,
            level: 'None',
            detail: 'Flood risk conditions near you',
            filled: 1,
            tip: 'No flash-flood advisories in your area.',
            iconBg: AppTheme.brand50,
            iconColor: AppTheme.brand600,
          ),
          const SizedBox(height: 10),
          MockFactorRow(
            icon: Icons.grass_outlined,
            title: l10n.mockPollenAxis,
            level: 'Moderate',
            detail: 'Tree and grass pollen levels',
            filled: 3,
            levelColor: AppTheme.warning600,
            barColor: AppTheme.warning500,
            iconBg: AppTheme.warning50,
            iconColor: AppTheme.warning600,
            borderColor: AppTheme.warning200,
            tip: 'Tree pollen elevated — limit outdoor time 10 AM–4 PM.',
          ),
          const SizedBox(height: 16),
          Text(
            'TRAP uses modeled pollution data, not vehicle counts',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: AppTheme.neutral400),
          ),
          const SizedBox(height: 20),
          MockPrimaryCta(
            label: l10n.mockForecast,
            icon: Icons.trending_up,
            onPressed: () => MockNav.push(context, MockScreenId.patForecast),
          ),
        ],
      ),
    );
  }
}

class PatForecastMock extends StatelessWidget {
  const PatForecastMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final days = [
      ('Fri', '25'),
      ('Sat', '26'),
      ('Sun', '27'),
      ('Mon', '28'),
      ('Tue', '29'),
    ];
    return MockScreenChrome(
      screenId: MockScreenId.patForecast.id,
      title: l10n.mockForecast,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Daily Forecast', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Text('Environmental risk outlook', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 16),
          const Text('Select Day', style: TextStyle(fontSize: 12, color: AppTheme.neutral500)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < days.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Container(
                    width: 56,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: i == 0 ? AppTheme.brand600 : AppTheme.neutral0,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: i == 0 ? AppTheme.brand600 : AppTheme.neutral200),
                    ),
                    child: Column(
                      children: [
                        Text(
                          days[i].$1,
                          style: TextStyle(
                            fontSize: 11,
                            color: i == 0 ? AppTheme.brand200 : AppTheme.neutral400,
                          ),
                        ),
                        Text(
                          days[i].$2,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: i == 0 ? Colors.white : AppTheme.neutral700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Time of Day', style: TextStyle(fontSize: 12, color: AppTheme.neutral500)),
          const SizedBox(height: 8),
          MockFilterChipRow(labels: const ['Morning', 'Afternoon', 'Evening']),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            children: [
              const Expanded(
                child: Text('Risk Forecast', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              Text(
                'Fri 25 Jul — Morning',
                style: const TextStyle(fontSize: 12, color: AppTheme.neutral400),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _forecastChip(l10n.mockTrapAxis, 'Low', 1, AppTheme.brand50, AppTheme.brand600),
                const SizedBox(width: 10),
                _forecastChip(l10n.mockFloodAxis, 'None', 1, AppTheme.neutral0, AppTheme.brand600),
                const SizedBox(width: 10),
                _forecastChip(
                  l10n.mockPollenAxis,
                  'Moderate',
                  3,
                  AppTheme.warning50,
                  AppTheme.warning600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MockRiskBanner(
            warning: false,
            stateLabel: l10n.mockStateCalm,
            message: 'Overall risk is low this morning',
          ),
          const SizedBox(height: 20),
          MockPrimaryCta(
            label: 'View Full Report',
            icon: Icons.description_outlined,
            onPressed: () => MockNav.push(context, MockScreenId.patReport),
          ),
        ],
      ),
    );
  }

  Widget _forecastChip(String title, String level, int filled, Color bg, Color accent) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: accent)),
          const SizedBox(height: 8),
          Text(level, style: TextStyle(fontWeight: FontWeight.w700, color: accent)),
          const Spacer(),
          MockLevelBar(filled: filled, activeColor: accent),
        ],
      ),
    );
  }
}

class PatLogMock extends StatelessWidget {
  const PatLogMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        MockBrandHeader(title: l10n.appTitle, screenId: MockScreenId.patLog.id),
        const SizedBox(height: 16),
        const Text('Inhaler Log', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Track your medication use', style: TextStyle(color: AppTheme.subtext)),
        const SizedBox(height: 12),
        MockFilterChipRow(labels: const ['All', 'Rescue', 'Controller', 'Missed']),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.brand50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.bar_chart, color: AppTheme.brand600, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('7 uses this week', style: TextStyle(fontSize: 12, color: AppTheme.brand700)),
              ),
              Text(
                '5 rescue | 2 controller',
                style: const TextStyle(fontSize: 12, color: AppTheme.brand600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            children: [
              MockNavTile(
                icon: Icons.quiz_outlined,
                title: l10n.mockActSurvey,
                subtitle: l10n.mockActHint,
                target: MockScreenId.patAct,
              ),
              const Divider(),
              MockNavTile(
                icon: Icons.task_alt_outlined,
                title: l10n.mockPdcCheck,
                subtitle: l10n.mockPdcHint,
                target: MockScreenId.patPdc,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Text('Today', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(width: 8),
            Text('Jul 25', style: TextStyle(fontSize: 12, color: AppTheme.neutral400)),
          ],
        ),
        const SizedBox(height: 8),
        _logCard('Albuterol', 'Rescue', '8:15 AM', '2 puffs', 'Wheezing before use', true),
        _logCard('Fluticasone', 'Controller', '7:00 AM', '1 puff', 'Morning routine', false),
        const SizedBox(height: 8),
        const Row(
          children: [
            Text('Yesterday', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(width: 8),
            Text('Jul 24', style: TextStyle(fontSize: 12, color: AppTheme.neutral400)),
          ],
        ),
        const SizedBox(height: 8),
        _logCard('Albuterol', 'Rescue', '9:30 PM', '2 puffs', 'Shortness of breath', true),
      ],
    );
  }

  Widget _logCard(
    String name,
    String type,
    String time,
    String dose,
    String note,
    bool rescue,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MockSectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: rescue ? AppTheme.brand100 : AppTheme.neutral100,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 11,
                      color: rescue ? AppTheme.brand700 : AppTheme.neutral600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('$time · $dose', style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: rescue ? AppTheme.warning50 : const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                note,
                style: TextStyle(
                  fontSize: 12,
                  color: rescue ? AppTheme.warning700 : AppTheme.success600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatActMock extends StatelessWidget {
  const PatActMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final options = [
      ('All the time', '1 point'),
      ('Most of the time', '2 points'),
      ('Some of the time', '3 points'),
      ('A little of the time', '4 points'),
      ('Not at all', '5 points'),
    ];
    return MockScreenChrome(
      screenId: MockScreenId.patAct.id,
      title: 'Asthma Check',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MockLevelBar(filled: 1, height: 6, activeColor: AppTheme.brand500),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${l10n.mockQuestion} 1 of 5',
                style: const TextStyle(fontSize: 12, color: AppTheme.brand600),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.brand50,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text('~3 min', style: TextStyle(fontSize: 12, color: AppTheme.brand600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Icon(Icons.accessibility_new, size: 48, color: AppTheme.brand600),
          const SizedBox(height: 12),
          const Text(
            'How much did asthma limit your activities?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          const Text(
            'In the past 4 weeks',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.subtext),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MockSectionCard(
                color: i == 0 ? AppTheme.brand50 : null,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(options[i].$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                          Text(options[i].$2, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                        ],
                      ),
                    ),
                    Icon(
                      i == 0 ? Icons.check_circle : Icons.circle_outlined,
                      color: i == 0 ? AppTheme.brand600 : AppTheme.neutral300,
                    ),
                  ],
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.brand50,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              '+10 points for completing this check',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppTheme.brand700),
            ),
          ),
          const SizedBox(height: 20),
          MockPrimaryCta(
            label: 'Next',
            icon: Icons.arrow_forward,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class PatPdcMock extends StatelessWidget {
  const PatPdcMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patPdc.id,
      title: 'Daily Check-in',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Daily Check-in', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Text('Track your medication adherence', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.brand50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.brand200),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.brand100,
                  child: Icon(Icons.local_fire_department, color: AppTheme.brand600),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('5-Day Streak', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.brand600,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: const Text('PDC 86%', style: TextStyle(color: Colors.white, fontSize: 11)),
                          ),
                        ],
                      ),
                      const Text("Keep it up! You're doing great", style: TextStyle(fontSize: 12, color: AppTheme.brand700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Last 7 Days', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final missed = i == 2;
              final today = i == 6;
              return Column(
                children: [
                  Text(['S', 'S', 'M', 'T', 'W', 'T', 'F'][i], style: const TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                  const SizedBox(height: 6),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: missed
                        ? const Color(0xFFFEE2E2)
                        : today
                            ? AppTheme.brand600
                            : AppTheme.brand100,
                    child: Icon(
                      missed ? Icons.close : Icons.check,
                      size: 18,
                      color: missed
                          ? AppTheme.error500
                          : today
                              ? Colors.white
                              : AppTheme.brand600,
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),
          MockSectionCard(
            color: AppTheme.brand50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.mockPdcPrompt, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                MockPrimaryCta(
                  label: l10n.mockTakenYes,
                  icon: Icons.check_circle_outline,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.mockTakenNo),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Monthly Progress', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          MockSectionCard(
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(child: Text('Days Covered')),
                    Text('22 / 25', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: const LinearProgressIndicator(
                    value: 0.88,
                    minHeight: 10,
                    backgroundColor: AppTheme.neutral200,
                    color: AppTheme.brand500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PatReportMock extends StatelessWidget {
  const PatReportMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        MockBrandHeader(title: l10n.appTitle, screenId: MockScreenId.patReport.id),
        const SizedBox(height: 16),
        const Text('My Report', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Evidence summary — Jul 2026', style: TextStyle(color: AppTheme.subtext)),
        const SizedBox(height: 16),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Inhaler Use', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                '12',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.brand600, fontWeight: FontWeight.w700),
              ),
              const Text('total puffs · Past 7 days', style: TextStyle(color: AppTheme.subtext, fontSize: 13)),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final h in [20.0, 32.0, 12.0, 48.0, 28.0, 20.0, 24.0])
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          height: h,
                          decoration: BoxDecoration(
                            color: h > 40 ? AppTheme.warning500 : AppTheme.brand300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MockSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.mockActScore, style: const TextStyle(fontSize: 12)),
                    const Text('18 / 25', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.warning600)),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppTheme.warning50, borderRadius: BorderRadius.circular(99)),
                      child: const Text('Not well controlled', style: TextStyle(fontSize: 11, color: AppTheme.warning700)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MockSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.mockPdcRate, style: const TextStyle(fontSize: 12)),
                    const Text('82%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.brand600)),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppTheme.brand50, borderRadius: BorderRadius.circular(99)),
                      child: const Text('Above 80% target', style: TextStyle(fontSize: 11, color: AppTheme.brand700)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Environment Risk', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _envMini(l10n.mockTrapAxis, 'Low', AppTheme.brand600)),
            const SizedBox(width: 8),
            Expanded(child: _envMini(l10n.mockPollenAxis, 'Moderate', AppTheme.warning600)),
            const SizedBox(width: 8),
            Expanded(child: _envMini(l10n.mockFloodAxis, 'None', AppTheme.brand600)),
          ],
        ),
        const SizedBox(height: 12),
        MockRiskBanner(
          warning: false,
          stateLabel: l10n.mockStateCalm,
          message: 'Overall risk is low today',
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recent Symptoms', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text('Wheezing'), backgroundColor: AppTheme.warning50),
                  Chip(label: Text('SOB'), backgroundColor: AppTheme.warning50),
                  Chip(label: Text('Cough'), backgroundColor: AppTheme.brand50),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        MockPrimaryCta(label: 'Share Report', icon: Icons.ios_share, onPressed: () {}),
      ],
    );
  }

  Widget _envMini(String title, String level, Color color) {
    return MockSectionCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(level, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class PatLocationsMock extends StatelessWidget {
  const PatLocationsMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patLocations.id,
      title: 'My Locations',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Saved Locations', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Text('Used for local air quality and alerts', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 12),
          MockFilterChipRow(labels: const ['All', 'Home', 'School', 'Work']),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Text('Your Places', style: TextStyle(fontWeight: FontWeight.w700))),
              Text('2 saved', style: const TextStyle(fontSize: 12, color: AppTheme.neutral400)),
            ],
          ),
          const SizedBox(height: 8),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.home_outlined, color: AppTheme.brand600),
                    const SizedBox(width: 8),
                    Text(l10n.mockHomeLocation, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppTheme.brand100, borderRadius: BorderRadius.circular(99)),
                      child: const Text('Primary', style: TextStyle(fontSize: 11, color: AppTheme.brand700)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(l10n.mockDummyAddress, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
                const SizedBox(height: 8),
                const Text('TRAP monitoring active · Flood alerts on', style: TextStyle(fontSize: 12, color: AppTheme.brand700)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.work_outline, color: AppTheme.neutral500),
                    const SizedBox(width: 8),
                    Text(l10n.mockWorkLocation, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Spacer(),
                    const Text('Secondary', style: TextStyle(fontSize: 11, color: AppTheme.neutral500)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(l10n.mockDummyWorkAddress, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_location_alt_outlined),
            label: Text(l10n.mockAddLocation),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
            label: const Text('Use Current Location'),
          ),
        ],
      ),
    );
  }
}

class PatRewardMock extends StatelessWidget {
  const PatRewardMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        MockBrandHeader(title: l10n.appTitle, screenId: MockScreenId.patReward.id),
        const SizedBox(height: 12),
        MockDraftBanner(message: l10n.mockDraftBanner),
        const SizedBox(height: 16),
        const Text('Rewards', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Text('Earn points, redeem rewards', style: TextStyle(color: AppTheme.subtext)),
        const SizedBox(height: 16),
        MockSectionCard(
          color: AppTheme.brand50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.mockPointsBalance, style: const TextStyle(color: AppTheme.subtext)),
              const Text('320', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: AppTheme.brand700)),
              const Text('180 earned · 140 bonus', style: TextStyle(fontSize: 12, color: AppTheme.brand600)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('How You Earn', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        MockSectionCard(
          child: Column(
            children: [
              _earnRow('Daily Inhaler Log', 'Log each use to earn points', '+5 pts'),
              const Divider(),
              _earnRow(l10n.mockActSurvey, 'Complete monthly assessment', '+10 pts'),
              const Divider(),
              _earnRow('7-Day Streak', 'Log every day for a week', '+25 pts'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            children: [
              MockNavTile(
                icon: Icons.card_giftcard_outlined,
                title: l10n.mockVoucherTitle,
                subtitle: '50-pt voucher',
                target: MockScreenId.patVoucher,
              ),
              const Divider(),
              MockNavTile(
                icon: Icons.volunteer_activism_outlined,
                title: l10n.mockDonateTitle,
                subtitle: l10n.mockDonateHint,
                target: MockScreenId.patDonate,
              ),
              const Divider(),
              MockNavTile(
                icon: Icons.history,
                title: l10n.mockRewardHistory,
                subtitle: l10n.mockRewardHistoryHint,
                target: MockScreenId.patRewardHist,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _earnRow(String title, String subtitle, String pts) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
      trailing: Text(pts, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
    );
  }
}

class PatVoucherMock extends StatelessWidget {
  const PatVoucherMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patVoucher.id,
      title: 'Redeem Voucher',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MockDraftBanner(message: l10n.mockDraftBanner),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Balance', style: TextStyle(color: AppTheme.subtext)),
                const Text('120 points available', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Exchange Item', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(l10n.mockDummyFoodBank, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(l10n.mockVoucherCost, style: const TextStyle(color: AppTheme.subtext)),
                const SizedBox(height: 12),
                const Text('Important Notice', style: TextStyle(fontWeight: FontWeight.w700)),
                const Text(
                  'Points are held until a partner is confirmed',
                  style: TextStyle(fontSize: 13, color: AppTheme.subtext),
                ),
                const SizedBox(height: 16),
                MockPrimaryCta(
                  label: l10n.mockJoinWaitlist,
                  icon: Icons.hourglass_empty,
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PatDonateMock extends StatelessWidget {
  const PatDonateMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patDonate.id,
      title: l10n.mockDonateTitle,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Support asthma research', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 12),
          MockSectionCard(child: Text(l10n.mockDonateTransparency)),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('1,250 Points', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                const Text('\$12.50 value · Available for donation', style: TextStyle(color: AppTheme.subtext)),
                const SizedBox(height: 16),
                const Text('Select Amount', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                MockFilterChipRow(labels: const ['\$5', '\$10', '\$25', '\$50', '\$100', 'Other'], selectedIndex: 1),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MockPrimaryCta(
            label: l10n.mockDonateCta,
            icon: Icons.open_in_new,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.mockExternalOnly)),
              );
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'Donation provider not yet finalized',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppTheme.neutral400),
          ),
        ],
      ),
    );
  }
}

class PatRewardHistMock extends StatelessWidget {
  const PatRewardHistMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rows = [
      ('+10 pts', 'Daily check-in', 'Today', null),
      ('Donate 50 pts', 'Provider TBD — donation queued', 'Today', 'Pending'),
      ('Voucher request', '150 pts — placeholder pending partner', 'Yesterday', 'Waitlisted'),
      ('+5 pts', l10n.mockInhalerEvent, 'Yesterday', null),
      ('Donate 25 pts', 'No provider — points refunded', 'Jul 23', 'Failed'),
    ];
    return MockScreenChrome(
      screenId: MockScreenId.patRewardHist.id,
      title: l10n.mockRewardHistory,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MockDraftBanner(message: l10n.mockDraftBanner),
          const SizedBox(height: 12),
          MockFilterChipRow(labels: const ['All', 'Earn', 'Voucher', 'Donate']),
          const SizedBox(height: 12),
          const Text('Balance: 185 pts · Lifetime: 340 pts', style: TextStyle(fontSize: 12, color: AppTheme.subtext)),
          const SizedBox(height: 12),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MockSectionCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(row.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                          Text(row.$2, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                          Text(row.$3, style: const TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                        ],
                      ),
                    ),
                    if (row.$4 != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.warning50,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(row.$4!, style: const TextStyle(fontSize: 11, color: AppTheme.warning700)),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PatSettingsMock extends StatelessWidget {
  const PatSettingsMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        Text(l10n.settingsTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        Text(MockScreenId.patSettings.id, style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
        const SizedBox(height: 16),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.settingsLanguageLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  MockChip(label: 'EN', selected: true),
                  MockChip(label: 'ES'),
                  MockChip(label: 'FR'),
                  MockChip(label: 'KO'),
                  MockChip(label: 'JA'),
                  MockChip(label: 'ZH'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Alert Preferences', style: TextStyle(fontWeight: FontWeight.w700)),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Risk Alerts'),
                subtitle: const Text('Score changes and warnings'),
                value: true,
                onChanged: (_) {},
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Home Alerts'),
                subtitle: const Text('TRAP and pollen at home location'),
                value: true,
                onChanged: (_) {},
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Travel Alerts'),
                subtitle: const Text('Air quality when away from home'),
                value: false,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Security', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Biometric Login'),
                subtitle: const Text('Face ID or fingerprint'),
                value: true,
                onChanged: (_) {},
              ),
              const Divider(),
              MockNavTile(
                icon: Icons.place_outlined,
                title: l10n.mockLocationsTitle,
                subtitle: l10n.mockLocationsHint,
                target: MockScreenId.patLocations,
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.contact_phone_outlined, color: AppTheme.brand600),
                title: Text(l10n.mockEmergencyContact),
                subtitle: Text(l10n.mockDummyContact),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.link, color: AppTheme.brand600),
                title: const Text('Provider Pairing'),
                subtitle: Text(l10n.mockInviteCode),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.grid_view_rounded, color: AppTheme.brand600),
                title: Text(l10n.mockAllScreens),
                onTap: () => MockNav.openCatalog(context),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: AppTheme.error600),
                title: Text(l10n.mockSignOutPreview),
                onTap: () => MockNav.push(context, MockScreenId.auth02),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
