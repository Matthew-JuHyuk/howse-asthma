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
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.brand600,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.air, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                  Text(id.id, style: const TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => MockNav.openCatalog(context),
              icon: const Icon(Icons.grid_view_rounded),
              tooltip: l10n.mockAllScreens,
            ),
          ],
        ),
        const SizedBox(height: 16),
        MockRiskBanner(
          warning: warning,
          stateLabel: warning ? l10n.mockStateWarning : l10n.mockStateCalm,
          message: warning ? l10n.mockHomeWarnMessage : l10n.mockHomeCalmMessage,
        ),
        const SizedBox(height: 16),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.mockRiskScore, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(
                warning ? '3 / 4' : '1 / 4',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: warning ? AppTheme.warning600 : AppTheme.brand700,
                ),
              ),
              Text(l10n.mockDummyLocation, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            children: [
              MockNavTile(
                icon: Icons.layers_outlined,
                title: l10n.mockEnvDetail,
                subtitle: 'TRAP · Flood · Pollen',
                target: MockScreenId.patEnv,
              ),
              const Divider(),
              MockNavTile(
                icon: Icons.calendar_month_outlined,
                title: l10n.mockForecast,
                subtitle: l10n.mockForecastHint,
                target: MockScreenId.patForecast,
              ),
              const Divider(),
              MockNavTile(
                icon: Icons.notifications_active_outlined,
                title: l10n.mockAlertPreview,
                subtitle: l10n.mockAlertPreviewHint,
                target: MockScreenId.sysAlert,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
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
        const SizedBox(height: 20),
        MockPrimaryCta(
          label: l10n.medicationLogAddButton,
          icon: Icons.medication_outlined,
          onPressed: () => MockNav.push(context, MockScreenId.patLog),
        ),
        const SizedBox(height: 10),
        MockPrimaryCta(
          label: l10n.mockPanicCta,
          icon: Icons.emergency_outlined,
          color: AppTheme.error500,
          onPressed: () => MockNav.push(context, MockScreenId.sysPanic),
        ),
      ],
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
      title: l10n.mockEnvDetail,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _axisCard(l10n.mockTrapAxis, 'MODERATE', 'PM2.5 18 · AADT weight near freight'),
          const SizedBox(height: 12),
          _axisCard(l10n.mockFloodAxis, 'CLEAR', 'No NWS flash flood · USGS stable'),
          const SizedBox(height: 12),
          _axisCard(l10n.mockPollenAxis, 'UPI 2', 'Tree pollen · Google Pollen'),
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

  Widget _axisCard(String title, String level, String detail) {
    return MockSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(level, style: const TextStyle(color: AppTheme.brand700, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(detail, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
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
    final days = ['Today', 'Sat', 'Sun', 'Mon', 'Tue'];
    return MockScreenChrome(
      screenId: MockScreenId.patForecast.id,
      title: l10n.mockForecast,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          return MockSectionCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(days[i], style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(l10n.mockForecastDayHint, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
                    ],
                  ),
                ),
                Text('${i + 1}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.brand700)),
              ],
            ),
          );
        },
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
        Text(l10n.medicationLogTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        Text(MockScreenId.patLog.id, style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
        const SizedBox(height: 16),
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
        const SizedBox(height: 12),
        ...List.generate(3, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MockSectionCard(
              child: Row(
                children: [
                  const Icon(Icons.medication, color: AppTheme.brand600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.mockInhalerEvent, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('Today · ${10 - i}:30 AM · AQI 42', style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        MockPrimaryCta(
          label: l10n.medicationLogAddButton,
          onPressed: () {},
        ),
      ],
    );
  }
}

class PatActMock extends StatelessWidget {
  const PatActMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patAct.id,
      title: l10n.mockActSurvey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.mockActIntro),
          const SizedBox(height: 16),
          ...List.generate(5, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MockSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l10n.mockQuestion} ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: List.generate(5, (score) {
                        return MockChip(label: '${score + 1}', selected: score == 3);
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
          MockPrimaryCta(
            label: l10n.mockSubmit,
            icon: Icons.check,
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
      title: l10n.mockPdcCheck,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            Text(l10n.mockPdcPrompt, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 28),
            MockPrimaryCta(
              label: l10n.mockTakenYes,
              icon: Icons.check_circle_outline,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.mockTakenNo),
            ),
            const Spacer(),
          ],
        ),
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
        Text(l10n.reportTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        Text(MockScreenId.patReport.id, style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
        const SizedBox(height: 16),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.mockEvidenceSummary, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(l10n.mockEvidenceBody, style: const TextStyle(color: AppTheme.subtext)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        MockSectionCard(
          child: Column(
            children: [
              _statRow(l10n.mockInhalerEvents30d, '14'),
              const Divider(),
              _statRow(l10n.mockActScore, '19'),
              const Divider(),
              _statRow(l10n.mockPdcRate, '86%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
      ],
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
      title: l10n.mockLocationsTitle,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MockSectionCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.home_outlined, color: AppTheme.brand600),
              title: Text(l10n.mockHomeLocation),
              subtitle: Text(l10n.mockDummyAddress),
              trailing: Switch(value: true, onChanged: (_) {}),
            ),
          ),
          const SizedBox(height: 10),
          MockSectionCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.work_outline, color: AppTheme.neutral500),
              title: Text(l10n.mockWorkLocation),
              subtitle: Text(l10n.mockDummyWorkAddress),
              trailing: Switch(value: false, onChanged: (_) {}),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_location_alt_outlined),
            label: Text(l10n.mockAddLocation),
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
        Text(l10n.mockRewardTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        Text(MockScreenId.patReward.id, style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
        const SizedBox(height: 12),
        MockDraftBanner(message: l10n.mockDraftBanner),
        const SizedBox(height: 16),
        MockSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.mockPointsBalance, style: const TextStyle(color: AppTheme.subtext)),
              const Text('128', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: AppTheme.brand700)),
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
                subtitle: l10n.mockVoucherHint,
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
}

class PatVoucherMock extends StatelessWidget {
  const PatVoucherMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.patVoucher.id,
      title: l10n.mockVoucherTitle,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MockDraftBanner(message: l10n.mockDraftBanner),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.mockDummyFoodBank, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(l10n.mockVoucherCost, style: const TextStyle(color: AppTheme.subtext)),
                const SizedBox(height: 16),
                MockPrimaryCta(
                  label: l10n.mockJoinWaitlist,
                  icon: Icons.hourglass_empty,
                  onPressed: () => Navigator.pop(context),
                ),
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
          MockSectionCard(
            child: Text(l10n.mockDonateTransparency),
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
      ('+2', l10n.mockInhalerEvent),
      ('+1', l10n.mockPdcCheck),
      ('+10', l10n.mockActSurvey),
    ];
    return MockScreenChrome(
      screenId: MockScreenId.patRewardHist.id,
      title: l10n.mockRewardHistory,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: rows.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final row = rows[i];
          return MockSectionCard(
            child: Row(
              children: [
                Text(row.$1, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.success600, fontSize: 18)),
                const SizedBox(width: 16),
                Expanded(child: Text(row.$2)),
              ],
            ),
          );
        },
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
            children: [
              MockNavTile(
                icon: Icons.place_outlined,
                title: l10n.mockLocationsTitle,
                subtitle: l10n.mockLocationsHint,
                target: MockScreenId.patLocations,
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.brand100,
                  child: Icon(Icons.language, color: AppTheme.brand700, size: 20),
                ),
                title: Text(l10n.settingsLanguageLabel),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.chevron_right, color: AppTheme.neutral400),
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
                subtitle: Text(l10n.mockAllScreensHint),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => MockNav.openCatalog(context),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: AppTheme.error600),
                title: Text(l10n.mockSignOutPreview),
                onTap: () => MockNav.push(context, MockScreenId.auth02),
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.waving_hand_outlined, color: AppTheme.brand600),
                title: Text(l10n.mockOpenAuthFlow),
                onTap: () => MockNav.push(context, MockScreenId.auth01),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
