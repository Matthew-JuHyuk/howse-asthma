import 'package:flutter/material.dart';

import '../../../core/locale/language_picker.dart';
import '../../../core/session/session_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';
import 'capture_screen.dart';
import 'case_card.dart';
import 'quick_log.dart';
import 'routes.dart';
import 'preparation_screen.dart';
import 'preparation_strings.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import 'covernote_nav.dart';
import '../domain/s9_models.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    super.key,
    required this.onOpenCases,
    required this.onOpenAccount,
  });

  final VoidCallback onOpenCases;
  final VoidCallback onOpenAccount;

  @override
  State<HomeTab> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  List<CaseSummary>? _cases;
  String? _error;
  String? _loadedFor;
  Preparation? _preparation;
  List<TreatmentEvent> _records = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    final uid = s.isReady ? s.user?.id : null;
    if (uid != _loadedFor) {
      _loadedFor = uid;
      _cases = null;
      _preparation = null;
      if (uid != null) refresh();
    }
  }

  Future<void> refresh() async {
    if (_loadedFor == null) return;
    final owner = _loadedFor;
    try {
      final list = await CoverNoteServices.of(context).live.listCases();
      final active = list
          .where((c) => c.row.lifecycle == CaseLifecycle.active)
          .firstOrNull;
      Preparation? preparation;
      List<TreatmentEvent> records = [];
      if (active != null) {
        try {
          preparation = await PreparationRepository().load(active.row.id);
          records = await PreparationRepository().events();
        } catch (_) {
          /* Legacy case retains its existing records entry. */
        }
      }
      if (!mounted || _loadedFor != owner) return;
      setState(() {
        _cases = list;
        _preparation = preparation;
        _records = records;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    }
  }

  Future<void> _start(CaptureSource source) async {
    await startNewCase(context, source);
    if (mounted) await refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = SessionScope.of(context);
    final signedIn = session.isReady;
    final cases = _cases ?? const <CaseSummary>[];
    final active = cases
        .where(
          (c) =>
              c.row.status != 'deleting' &&
              c.row.lifecycle == CaseLifecycle.active,
        )
        .toList();
    final current = active.isEmpty ? null : active.first;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Row(
              children: [
                const Expanded(child: BrandLockup(compact: true)),
                const LanguageButton(),
                _AccountButton(
                  signedIn: signedIn,
                  name: session.profile?.fullName,
                  onOpenAccount: widget.onOpenAccount,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              s10(context, 'purpose'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: CnColors.navy,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              TextButton.icon(
                onPressed: refresh,
                icon: const Icon(Icons.refresh),
                label: Text(l.cnRetry),
              ),
            if (signedIn && current != null) ...[
              SectionLabel(l.cnContinueCase),
              if (_preparation case final p?)
                CnCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.patientName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${p.needs.where((n) => n.links.any((id) => _records.any((e) => e.id == id && !e.undone))).length} / ${p.needs.length} · ${s10(context, 'progress')}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: p.needs.isEmpty
                            ? 0
                            : p.needs
                                      .where(
                                        (n) => n.links.any(
                                          (id) => _records.any(
                                            (e) => e.id == id && !e.undone,
                                          ),
                                        ),
                                      )
                                      .length /
                                  p.needs.length,
                        minHeight: 8,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${TreatmentSummary(p, _records, DateTime.now()).observedDays} ${s10(context, 'recordedDays')}',
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () async {
                            await openCase(
                              context,
                              CoverNoteServices.of(context).live,
                              current.row.id,
                            );
                            if (mounted) await refresh();
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: Text(s10(context, 'gatherStep')),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_preparation == null)
                CaseCard(
                  summary: current,
                  onTap: () async {
                    await openCase(
                      context,
                      CoverNoteServices.of(context).live,
                      current.row.id,
                    );
                    if (mounted) await refresh();
                  },
                ),
            ],
            if (!signedIn && session.status != SessionStatus.unconfigured) ...[
              const SizedBox(height: 4),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    l.cnHomeSignInLine,
                    style: const TextStyle(color: CnColors.muted),
                  ),
                  TextButton(
                    onPressed: () => requireSignIn(context),
                    child: Text(l.cnAuthSignIn),
                  ),
                ],
              ),
            ],
            if (session.status == SessionStatus.unconfigured) ...[
              const SizedBox(height: 8),
              Text(
                l.cnServiceNotConfigured,
                textAlign: TextAlign.center,
                style: const TextStyle(color: CnColors.warn),
              ),
            ],
            if (signedIn && current != null) ...[
              const SizedBox(height: 24),
              SectionLabel(l.cnHomeRecords),
              if (_preparation case final p?)
                CnCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: CnColors.teal,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${TreatmentSummary(p, _records, DateTime.now()).observedDays} ${s10(context, 'recordedDays')}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(s10(context, 'centerHint')),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: CoverNoteNav.maybeOf(context)?.goRecords,
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(s10(context, 'timeline')),
                      ),
                    ],
                  ),
                )
              else
                const QuickLogPanel(),
            ],
            const SizedBox(height: 24),
            if (signedIn && current != null)
              ExpansionTile(
                title: Text(s10(context, 'otherCase')),
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 64),
                    child: FilledButton.icon(
                      onPressed: () async {
                        await startPreparation(context);
                        if (mounted) await refresh();
                      },
                      icon: const Icon(
                        Icons.document_scanner_outlined,
                        size: 28,
                      ),
                      label: Text(
                        s10(context, 'start'),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(s10(context, 'newHelp')),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 52),
                    child: OutlinedButton.icon(
                      onPressed: () => _start(CaptureSource.files),
                      icon: const Icon(Icons.upload_file_outlined),
                      label: Text(
                        s10(context, 'denied'),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(s10(context, 'denialHelp')),
                  ),
                  Align(
                    child: TextButton.icon(
                      onPressed: () => openDemo(context),
                      icon: const Icon(Icons.play_circle_outline, size: 20),
                      label: Text(l.cnTryDemo),
                    ),
                  ),
                ],
              )
            else ...[
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 64),
                child: FilledButton.icon(
                  onPressed: () async {
                    await startPreparation(context);
                    if (mounted) await refresh();
                  },
                  icon: const Icon(Icons.document_scanner_outlined, size: 28),
                  label: Text(
                    s10(context, 'start'),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Text(s10(context, 'newHelp')),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 52),
                child: OutlinedButton.icon(
                  onPressed: () => _start(CaptureSource.files),
                  icon: const Icon(Icons.upload_file_outlined),
                  label: Text(
                    s10(context, 'denied'),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Text(s10(context, 'denialHelp')),
              ),
              Align(
                child: TextButton.icon(
                  onPressed: () => openDemo(context),
                  icon: const Icon(Icons.play_circle_outline, size: 20),
                  label: Text(l.cnTryDemo),
                ),
              ),
            ],
            if (!signedIn) ...[SectionLabel(l.cnHowItWorks), _Steps()],
            if (signedIn)
              TextButton.icon(
                onPressed: widget.onOpenCases,
                icon: const Icon(Icons.folder_outlined),
                label: Text(l.cnSeeAllCases),
              ),
          ],
        ),
      ),
    );
  }
}

class _AccountButton extends StatelessWidget {
  const _AccountButton({
    required this.signedIn,
    required this.name,
    required this.onOpenAccount,
  });

  final bool signedIn;
  final String? name;
  final VoidCallback onOpenAccount;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final initial = (name ?? '').trim().isEmpty
        ? null
        : name!.trim().characters.first.toUpperCase();
    return IconButton(
      tooltip: signedIn ? l.cnTabAccount : l.cnAuthSignIn,
      iconSize: 36,
      onPressed: signedIn ? onOpenAccount : () => requireSignIn(context),
      icon: CircleAvatar(
        radius: 18,
        backgroundColor: signedIn ? CnColors.teal : CnColors.line,
        child: signedIn && initial != null
            ? Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              )
            : Icon(
                Icons.person_outline,
                color: signedIn ? Colors.white : CnColors.navy,
              ),
      ),
    );
  }
}

class _Steps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final steps = [
      (Icons.document_scanner_outlined, l.cnStep1Title, l.cnStep1Body),
      (Icons.fact_check_outlined, l.cnStep2Title, l.cnStep2Body),
      (Icons.picture_as_pdf_outlined, l.cnStep3Title, l.cnStep3Body),
    ];
    return CnCard(
      child: Column(
        children: [
          for (var i = 0; i < steps.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == steps.length - 1 ? 0 : 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: CnColors.mint,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: CnColors.navy,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].$2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          steps[i].$3,
                          style: const TextStyle(
                            color: CnColors.muted,
                            fontSize: 15,
                          ),
                        ),
                      ],
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
