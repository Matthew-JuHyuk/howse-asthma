import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/act_repository.dart';

/// SCR-PAT-ACT — 5-question Asthma Control Test → `act_assessments`.
class ActScreen extends StatefulWidget {
  const ActScreen({super.key});

  @override
  State<ActScreen> createState() => _ActScreenState();
}

class _ActScreenState extends State<ActScreen> {
  final _repo = ActRepository();
  int _index = 0;
  final List<int?> _answers = List<int?>.filled(5, null);
  bool _saving = false;

  List<String> _questions(AppLocalizations l10n) => [
        l10n.actQ1,
        l10n.actQ2,
        l10n.actQ3,
        l10n.actQ4,
        l10n.actQ5,
      ];

  /// Q1–Q4: frequency; Q5: control rating (still scored 1–5).
  List<String> _optionsForQuestion(AppLocalizations l10n, int questionIndex) {
    if (questionIndex == 4) {
      return [
        l10n.actQ5Opt1,
        l10n.actQ5Opt2,
        l10n.actQ5Opt3,
        l10n.actQ5Opt4,
        l10n.actQ5Opt5,
      ];
    }
    return [
      l10n.actOpt1,
      l10n.actOpt2,
      l10n.actOpt3,
      l10n.actOpt4,
      l10n.actOpt5,
    ];
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (_answers.any((a) => a == null)) return;
    setState(() => _saving = true);
    try {
      final lang = Localizations.localeOf(context).languageCode;
      final row = await _repo.submit(
        answers: _answers.cast<int>(),
        languageUsed: lang,
      );
      if (!mounted) return;
      final total = row['total_score'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.actSaved(total as int))),
      );
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authErrorGeneric)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final questions = _questions(l10n);
    final options = _optionsForQuestion(l10n, _index);
    final selected = _answers[_index];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.actTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text(
              'SCR-PAT-ACT',
              style: TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '${l10n.mockQuestion} ${_index + 1} of 5',
            style: const TextStyle(fontSize: 12, color: AppTheme.brand600),
          ),
          const SizedBox(height: 16),
          Text(
            questions[_index],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.actPast4Weeks,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppTheme.subtext),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: selected == (i + 1) ? AppTheme.brand50 : AppTheme.neutral0,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _answers[_index] = i + 1),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected == (i + 1)
                            ? AppTheme.brand600
                            : AppTheme.neutral200,
                        width: selected == (i + 1) ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      options[i],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (_index > 0)
                OutlinedButton(
                  onPressed: _saving
                      ? null
                      : () => setState(() => _index -= 1),
                  child: Text(l10n.mockBackToCalmHome),
                ),
              const Spacer(),
              FilledButton(
                onPressed: _saving || selected == null
                    ? null
                    : () {
                        if (_index < 4) {
                          setState(() => _index += 1);
                        } else {
                          _submit();
                        }
                      },
                child: Text(
                  _index < 4 ? l10n.mockNext : l10n.mockSubmit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
