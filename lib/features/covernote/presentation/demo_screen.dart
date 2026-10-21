import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../data/demo_case_store.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';
import 'case_card.dart';
import 'routes.dart';

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
              padding: const EdgeInsets.all(16),
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: DemoBadge(),
                ),
                const SizedBox(height: 8),
                Text(
                  l.cnDemoIntro,
                  style: const TextStyle(fontSize: 16, color: CnColors.muted),
                ),
                const SizedBox(height: 16),
                for (final c in cases) ...[
                  CaseCard(
                    summary: c,
                    today: DemoCaseStore.demoToday,
                    onTap: () async {
                      await openCase(context, widget.store, c.row.id);
                      _load();
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
    );
  }
}
