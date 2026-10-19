import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/appeal_demo_store.dart';
import '../data/appeal_pdf.dart';
import '../domain/appeal_models.dart';
import '../domain/clinician_page.dart';
import '../domain/deadline_resolver.dart';
import '../domain/explanation_builder.dart';

class AppealCaseScreen extends StatefulWidget {
  const AppealCaseScreen({super.key, required this.caseId});

  final String caseId;

  @override
  State<AppealCaseScreen> createState() => _AppealCaseScreenState();
}

class _AppealCaseScreenState extends State<AppealCaseScreen> {
  final _medController = TextEditingController();
  final _noteController = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final item = AppealDemoStore.instance.find(widget.caseId);
    _medController.text = item?.medicationRaw.rawText ?? '';
    _noteController.text = item?.selfReport ?? '';
  }

  @override
  void dispose() {
    _medController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: AppealDemoStore.instance,
      builder: (context, _) {
        final item = AppealDemoStore.instance.find(widget.caseId);
        if (item == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(l10n.v2Deleted)),
          );
        }
        final lang = Localizations.localeOf(context).languageCode;
        final deadline = resolveDeadline(
          item.deadline,
          userConfirmedDate: item.deadlineConfirmedByUser,
        );
        final explanation = buildExplanation(
          item,
          language: lang,
          deadline: deadline,
        );
        return Scaffold(
          appBar: AppBar(title: Text(item.shortId)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
            children: [
              const _Banner(),
              const SizedBox(height: 16),
              _section(l10n.v2ExplainTitle, [
                _numbered(1, explanation.reason.text),
                _numbered(2, explanation.nextAction.text),
                _numbered(3, explanation.deadline.text),
                const SizedBox(height: 8),
                ExpansionTile(
                  title: Text(l10n.v2Original),
                  children: [
                    SelectableText(item.pageText),
                  ],
                ),
              ]),
              _section(l10n.v2CheckTitle, [
                Text('${l10n.v2Patient}: ${_blank(item.patientName.rawText, l10n)}'),
                const SizedBox(height: 8),
                TextField(
                  controller: _medController,
                  decoration: InputDecoration(
                    labelText: l10n.v2EditMedication,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Text('${l10n.v2Dose}: ${_blank(item.doseRaw.rawText, l10n)}'),
                const SizedBox(height: 8),
                Text(
                  item.denialReason == null
                      ? l10n.v2ReasonMissing
                      : item.denialReason!.rawText,
                ),
                const SizedBox(height: 8),
                Text(_deadlineLabel(l10n, item, deadline)),
                if (deadline.date != null)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.v2ConfirmDate),
                    value: item.deadlineConfirmedByUser,
                    onChanged: (value) => AppealDemoStore.instance
                        .setDeadlineConfirmed(item.id, value),
                  ),
                const SizedBox(height: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => AppealDemoStore.instance.editMedication(
                    item.id,
                    _medController.text.trim(),
                  ),
                  child: Text(l10n.v2SaveEdit),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: AppTheme.brand700,
                  ),
                  onPressed: () => AppealDemoStore.instance.confirm(item.id),
                  child: Text(
                    item.preparedMinimumMet
                        ? l10n.v2Confirmed
                        : l10n.v2ConfirmFacts,
                  ),
                ),
              ]),
              _section(l10n.v2RecordsTitle, [
                Text(l10n.v2NoRecords),
                const SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: l10n.v2SelfReportLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => AppealDemoStore.instance.setSelfReport(
                    item.id,
                    _noteController.text,
                  ),
                  child: Text(l10n.v2SaveEdit),
                ),
              ]),
              _section(l10n.v2DocsTitle, [
                Text(l10n.v2EnglishDraft),
                const SizedBox(height: 4),
                Text(l10n.v2DraftBannerNote),
                if (item.letterText != null && !item.draftIsCurrent)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(l10n.v2StaleDraft),
                  ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: AppTheme.error600),
                    ),
                  ),
                const SizedBox(height: 8),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: AppTheme.brand700,
                  ),
                  onPressed: _busy
                      ? null
                      : () => _generate(item, ExportMode.review),
                  child: Text(l10n.v2GenerateReview),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: _busy
                      ? null
                      : () => _generate(item, ExportMode.preparedDraft),
                  child: Text(l10n.v2GeneratePrepared),
                ),
                if (item.letterText != null && item.draftIsCurrent) ...[
                  const SizedBox(height: 12),
                  SelectableText(item.letterText!),
                  const SizedBox(height: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: _busy ? null : () => _shareLetter(item),
                    child: Text(l10n.v2Share),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: _busy ? null : () => _shareClinician(item),
                    child: Text(l10n.v2ClinicianPdf),
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.v2ShareNotSubmitted),
                ],
              ]),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () async {
                  AppealDemoStore.instance.deleteCase(item.id);
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: Text(l10n.v2DeleteCase),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _generate(AppealCase item, ExportMode mode) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _error = null);
    try {
      AppealDemoStore.instance.generate(item.id, mode);
    } on AppealFlowException catch (error) {
      setState(() {
        _error = switch (error.code) {
          'prepared_requirements' => l10n.v2PreparedBlocked,
          'not_initial_denial' => l10n.v2NotInitial,
          _ => l10n.v2GenericError,
        };
      });
    }
  }

  Future<void> _shareLetter(AppealCase item) async {
    if (item.letterText == null || !item.draftIsCurrent) return;
    await _share(
      build: () => AppealPdf.buildLetter(item.letterText!),
      name: AppealPdf.fileName(item, 'appeal'),
    );
  }

  Future<void> _shareClinician(AppealCase item) async {
    final deadline = resolveDeadline(
      item.deadline,
      userConfirmedDate: item.deadlineConfirmedByUser,
    );
    final plan = fitClinicianPage(item, deadline: deadline);
    await _share(
      build: () => AppealPdf.buildClinician(plan),
      name: AppealPdf.fileName(item, 'clinician'),
    );
  }

  Future<void> _share({
    required Future<dynamic> Function() build,
    required String name,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final bytes = await build();
      await Printing.sharePdf(bytes: bytes, filename: name);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.v2ShareNotSubmitted)),
      );
    } on AppealPdfException {
      if (!mounted) return;
      setState(() => _error = l10n.v2FontUnavailable);
    } catch (error) {
      final message = error.toString().toLowerCase();
      if (message.contains('cancel')) return;
      if (!mounted) return;
      setState(() => _error = l10n.v2GenericError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.brand700),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        AppLocalizations.of(context)!.v2SampleBanner,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

Widget _section(String title, List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    ),
  );
}

Widget _numbered(int index, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text('$index. $text', style: const TextStyle(fontSize: 16, height: 1.35)),
  );
}

String _blank(String? value, AppLocalizations l10n) {
  if (value == null || value.trim().isEmpty) return l10n.v2NotEntered;
  return value;
}

String _deadlineLabel(
  AppLocalizations l10n,
  AppealCase item,
  DeadlineOutcome outcome,
) {
  final raw = item.deadline.rawText;
  return switch (outcome.display) {
    DeadlineDisplay.documentDate =>
      '${l10n.v2DocDeadline}: ${raw ?? ''}',
    DeadlineDisplay.calculatedFromReceived => l10n.v2CalcDeadline,
    DeadlineDisplay.needsReceivedDate => l10n.v2NeedReceived,
    DeadlineDisplay.notCalculable => l10n.v2UnclearDeadline,
    DeadlineDisplay.notFound => l10n.v2AskPlan,
  };
}
