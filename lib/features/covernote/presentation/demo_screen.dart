import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../data/demo_case_store.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';
import 'case_card.dart';
import 'routes.dart';
import 'preparation_screen.dart';
import 'preparation_strings.dart';

/// Public demo: fixed synthetic letters, no account, nothing uploaded.
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key, required this.store});

  final DemoCaseStore store;

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  List<CaseSummary>? _cases;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await widget.store.listCases();
    if (mounted) setState(() => _cases = list);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cases = _cases;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.cnDemoTitle),
        actions: [
          IconButton(
            tooltip: l.cnDemoReset,
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              widget.store.reset();
              _load();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l.cnDemoResetDone)));
            },
          ),
        ],
      ),
      body: cases == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                32 + MediaQuery.paddingOf(context).bottom,
              ),
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: DemoBadge(),
                ),
                const SizedBox(height: 16),
                Text(
                  l.cnDemoIntro,
                  style: const TextStyle(fontSize: 16, color: CnColors.muted),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => openPreparationDemo(context, false),
                  icon: const Icon(Icons.folder_open_outlined),
                  label: Text(s10(context, 'demoA')),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => openPreparationDemo(context, true),
                  icon: const Icon(Icons.mark_email_read_outlined),
                  label: Text(s10(context, 'demoB')),
                ),
                const SizedBox(height: 28),
                for (final c in cases) ...[
                  CaseCard(
                    summary: c,
                    today: DemoCaseStore.demoToday,
                    onTap: () async {
                      await openCase(context, widget.store, c.row.id);
                      _load();
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
    );
  }
}
