import 'dart:async';

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../data/case_store.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';
import 'capture_screen.dart';
import 'case_card.dart';
import 'case_labels.dart';
import 'evidence_step.dart';
import 'letter_view.dart';
import 'packet_step.dart';
import 'review_step.dart';

enum SaveState { idle, saving, saved, failed }

/// One case in four steps: Letter / Review / Evidence / Packet.
class CaseScreen extends StatefulWidget {
  const CaseScreen({super.key, required this.store, required this.caseId});

  final CaseStore store;
  final String caseId;

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  CaseDetail? _d;
  String? _loadError;
  bool _firstLoad = true;
  int _step = 0;

  // Facts being edited and autosaved.
  CaseFacts? _facts;
  CaseFacts? _original;
  int _factRev = 0;
  SaveState _save = SaveState.idle;
  Timer? _debounce;
  bool _inFlight = false;
  bool _again = false;
  bool _dirty = false;

  // Analysis job.
  CaseJob? _job;
  Timer? _poll;
  bool _starting = false;
  String? _jobError;
  bool _autoStarted = false;

  // Letter focus when jumping from a quote.
  int? _focusPage;
  String? _focusQuote;

  CaseStore get _store => widget.store;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _poll?.cancel();
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
      unawaited(_flush());
    }
    super.dispose();
  }

  bool _needsAnalysis(CaseDetail d) =>
      d.facts == null ||
      d.row.status == 'uploaded' ||
      d.row.status == 'processing' ||
      d.row.status == 'failed';

  Future<void> _load() async {
    try {
      final d = await _store.load(widget.caseId);
      if (!mounted) return;
      setState(() {
        _d = d;
        _loadError = null;
        _job = d.job;
        if (!_dirty && !_inFlight) {
          _facts = d.facts;
          _factRev = d.row.factRevision;
        }
        _original ??= d.facts;
        if (_firstLoad) {
          _firstLoad = false;
          _step = _defaultStep(d);
        }
      });
      if (_needsAnalysis(d)) _driveAnalysis();
    } on CaseStoreException catch (e) {
      if (mounted) setState(() => _loadError = e.code);
    } catch (_) {
      if (mounted) setState(() => _loadError = 'network');
    }
  }

  int _defaultStep(CaseDetail d) {
    final f = d.facts;
    if (f == null || _needsAnalysis(d)) return 0;
    if (!f.readyForEvidence) return 1;
    if (d.latestPacket != null) return 3;
    return 2;
  }

  // ---------------- Analysis ----------------

  void _driveAnalysis() {
    final d = _d;
    if (d == null || _store.isDemo) return;
    final job = _job;
    if (job == null) {
      if (!_autoStarted && d.files.isNotEmpty) {
        _autoStarted = true;
        _start();
      }
      return;
    }
    if (job.active) {
      if (job.leaseExpired(DateTime.now())) {
        _start();
      } else {
        _schedulePoll();
      }
    } else if (job.status == 'succeeded' && d.facts == null) {
      _schedulePoll();
    }
  }

  Future<void> _start({bool retry = false}) async {
    final d = _d;
    if (d == null || _starting) return;
    setState(() {
      _starting = true;
      _jobError = null;
    });
    try {
      final job = await _store.startAnalysis(
        widget.caseId,
        d.row.documentRevision,
        retry: retry,
      );
      if (!mounted) return;
      setState(() => _job = job ?? _job);
      if (job == null || job.active) {
        _schedulePoll();
      } else if (job.status == 'succeeded') {
        await _load();
      }
    } on CaseStoreException catch (e) {
      if (mounted) setState(() => _jobError = e.code);
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  void _schedulePoll() {
    _poll?.cancel();
    _poll = Timer(const Duration(seconds: 3), _pollOnce);
  }

  Future<void> _pollOnce() async {
    final d = _d;
    if (d == null || !mounted) return;
    try {
      final job = await _store.currentJob(
        widget.caseId,
        d.row.documentRevision,
      );
      if (!mounted) return;
      setState(() => _job = job);
      if (job == null) return;
      if (job.status == 'succeeded') {
        await _load();
        if (mounted && _d?.facts != null && !_needsAnalysis(_d!)) {
          setState(() => _step = 1);
        }
        return;
      }
      if (job.active) {
        if (job.leaseExpired(DateTime.now())) {
          await _start();
        } else {
          _schedulePoll();
        }
      }
    } catch (_) {
      // Offline: keep the last known state and try again a little later.
      if (mounted) _poll = Timer(const Duration(seconds: 8), _pollOnce);
    }
  }

  Future<void> _replacePages() async {
    final id = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => CaptureScreen(
          store: _store,
          source: CaptureSource.camera,
          replaceCaseId: widget.caseId,
        ),
      ),
    );
    if (id == null || !mounted) return;
    setState(() {
      _autoStarted = false;
      _job = null;
      _step = 0;
      _original = null;
    });
    await _load();
  }

  // ---------------- Facts autosave ----------------

  void _updateFacts(CaseFacts f, {bool immediate = false}) {
    setState(() {
      _facts = f;
      _dirty = true;
      _save = SaveState.saving;
    });
    _debounce?.cancel();
    _debounce = Timer(
      immediate ? Duration.zero : const Duration(milliseconds: 700),
      () => _flush(),
    );
  }

  Future<void> _flush() async {
    if (_inFlight) {
      _again = true;
      return;
    }
    final f = _facts;
    if (f == null || !_dirty) return;
    _inFlight = true;
    _dirty = false;
    try {
      final rev = await _store.saveFacts(widget.caseId, f, _factRev);
      _factRev = rev;
      if (mounted) {
        setState(() {
          _save = SaveState.saved;
          final d = _d;
          if (d != null) {
            _d = CaseDetail(
              row: d.row.copyWith(
                factRevision: rev,
                documentKind: f.kind,
                title: f.field('medication').value,
                status: f.readyForEvidence ? 'ready_for_draft' : 'needs_review',
              ),
              facts: f,
              requirements: d.requirements,
              evidence: d.evidence,
              artifacts: d.artifacts,
              pages: d.pages,
              files: d.files,
              job: d.job,
            );
          }
        });
      }
    } on CaseStoreException catch (e) {
      _dirty = true;
      if (mounted) {
        setState(() => _save = SaveState.failed);
        if (e.code == 'stale_facts') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.cnErrStale)),
          );
          _dirty = false;
          await _load();
        }
      }
    } catch (_) {
      _dirty = true;
      if (mounted) setState(() => _save = SaveState.failed);
    } finally {
      _inFlight = false;
      if (_again) {
        _again = false;
        await _flush();
      }
    }
  }

  /// Waits for pending edits to reach the server. Returns false if they could not.
  Future<bool> _flushNow() async {
    _debounce?.cancel();
    while (_inFlight) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    if (_dirty) await _flush();
    return !_dirty;
  }

  // ---------------- Navigation helpers ----------------

  void _showQuote(int? page, String? quote) {
    setState(() {
      _step = 0;
      _focusPage = page;
      _focusQuote = quote;
    });
  }

  Future<void> _goStep(int i) async {
    if (i >= 2 && !(_facts?.readyForEvidence ?? false)) return;
    if (_dirty || _inFlight) await _flushNow();
    if (mounted) setState(() => _step = i);
  }

  Future<void> _delete() async {
    final deleted = await confirmDeleteCase(
      context,
      () => _store.deleteCase(widget.caseId),
    );
    if (deleted && mounted) Navigator.pop(context);
  }

  // ---------------- Build ----------------

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final d = _d;
    return PopScope(
      canPop: _step == 0 || d == null || _needsAnalysis(d),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _step = _step - 1);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            d == null ? l.cnCaseUntitled : caseTitle(l, d.row),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            if (_save != SaveState.idle)
              _SaveIndicator(state: _save, onRetry: _flush),
            if (d != null)
              PopupMenuButton<String>(
                tooltip: l.cnMoreActions,
                onSelected: (v) {
                  if (v == 'replace') _replacePages();
                  if (v == 'delete') _delete();
                  if (v == 'original') openOriginalPages(context, _store, d);
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'original',
                    child: Text(l.cnViewOriginal),
                  ),
                  if (!_store.isDemo)
                    PopupMenuItem(
                      value: 'replace',
                      child: Text(l.cnReplacePages),
                    ),
                  if (!_store.isDemo)
                    PopupMenuItem(value: 'delete', child: Text(l.cnDeleteCase)),
                ],
              ),
          ],
          bottom: d == null
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: _StepBar(
                    step: _step,
                    enabled: [
                      true,
                      _facts != null && !_needsAnalysis(d),
                      _facts?.readyForEvidence == true && !_needsAnalysis(d),
                      _facts?.readyForEvidence == true && !_needsAnalysis(d),
                    ],
                    onTap: _goStep,
                  ),
                ),
        ),
        body: SafeArea(child: _body(l, d)),
      ),
    );
  }

  Widget _body(AppLocalizations l, CaseDetail? d) {
    if (d == null) {
      if (_loadError != null) {
        return Center(
          child: ActionMessage(
            icon: Icons.cloud_off,
            title: caseErrorText(l, _loadError!),
            actionLabel: l.cnRetry,
            onAction: _load,
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    }
    final demoBanner = d.row.demo || _store.isDemo
        ? const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Align(alignment: Alignment.centerLeft, child: DemoBadge()),
          )
        : const SizedBox.shrink();
    final facts = _facts;
    if (facts == null || _needsAnalysis(d)) {
      return ListView(children: [demoBanner, _processing(l, d)]);
    }
    final child = switch (_step) {
      1 => ReviewStep(
        facts: facts,
        original: _original ?? facts,
        today: _store.today,
        onChanged: _updateFacts,
        onShowQuote: _showQuote,
        onContinue: () => _goStep(2),
      ),
      2 => EvidenceStep(
        store: _store,
        detail: d,
        onChanged: _load,
        onShowQuote: _showQuote,
        onContinue: () => _goStep(3),
      ),
      3 => PacketStep(
        store: _store,
        detail: d,
        facts: facts,
        factRevision: _factRev,
        flush: _flushNow,
        onReload: _load,
        onGoReview: () => setState(() => _step = 1),
      ),
      _ => LetterView(
        store: _store,
        detail: d,
        facts: facts,
        focusPage: _focusPage,
        focusQuote: _focusQuote,
        onReplace: _store.isDemo ? null : _replacePages,
        onContinue: () => setState(() => _step = 1),
      ),
    };
    return Column(
      children: [
        demoBanner,
        Expanded(child: child),
      ],
    );
  }

  Widget _processing(AppLocalizations l, CaseDetail d) {
    final job = _job;
    final error =
        _jobError ??
        (job != null && job.failed
            ? (job.errorCode ?? 'internal_error')
            : null);
    if (error != null) {
      final unavailable =
          error == 'ai_not_configured' ||
          error == 'ai_auth_failed' ||
          error == 'ai_model_not_found';
      final canRetry =
          !unavailable &&
          (job == null || job.retryable || _jobError != null) &&
          error != 'attempts_exhausted';
      final newPages = job?.needsNewPages ?? false;
      return ActionMessage(
        icon: unavailable ? Icons.cloud_off : Icons.error_outline,
        title: caseErrorText(l, error),
        body: unavailable
            ? l.cnServiceUnavailableBody
            : (newPages ? l.cnNeedNewPagesBody : l.cnPagesKept),
        actionLabel: newPages
            ? l.cnReplacePages
            : (canRetry || unavailable ? l.cnTryAgain : null),
        onAction: newPages
            ? _replacePages
            : (canRetry || unavailable
                  ? () => _start(retry: job?.failed ?? false)
                  : null),
        secondaryLabel: newPages ? null : l.cnReplacePages,
        onSecondary: newPages ? null : _replacePages,
      );
    }
    final stepIndex = switch (job?.step) {
      'checking' => 2,
      'ready' => 3,
      _ => 1,
    };
    final labels = [
      l.cnStageUploading,
      l.cnStageReading,
      l.cnStageChecking,
      l.cnStageReady,
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.cnReadingTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: CnColors.navy,
            ),
          ),
          const SizedBox(height: 8),
          Text(l.cnReadingBody, style: const TextStyle(color: CnColors.muted)),
          const SizedBox(height: 16),
          for (var i = 0; i < labels.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: i < stepIndex
                        ? const Icon(Icons.check_circle, color: CnColors.teal)
                        : i == stepIndex
                        ? const Padding(
                            padding: EdgeInsets.all(4),
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          )
                        : const Icon(
                            Icons.radio_button_unchecked,
                            color: CnColors.line,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: i == stepIndex
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Text(
            l.cnReadingLeaveOk,
            style: const TextStyle(color: CnColors.muted, fontSize: 14),
          ),
          if (job == null && !_starting && !_store.isDemo) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _start(),
              icon: const Icon(Icons.play_arrow),
              label: Text(l.cnStartReading),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepBar extends StatelessWidget {
  const _StepBar({
    required this.step,
    required this.enabled,
    required this.onTap,
  });

  final int step;
  final List<bool> enabled;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final names = [
      l.cnStepLetter,
      l.cnStepReview,
      l.cnStepEvidence,
      l.cnStepPacket,
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        children: [
          for (var i = 0; i < names.length; i++)
            Expanded(
              child: Semantics(
                selected: i == step,
                button: true,
                enabled: enabled[i],
                label: l.cnStepOf(i + 1, names.length, names[i]),
                excludeSemantics: true,
                child: InkWell(
                  onTap: enabled[i] ? () => onTap(i) : null,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i == step ? CnColors.teal : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: i == step ? CnColors.teal : CnColors.line,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '${i + 1}. ${names[i]}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: i == step
                                ? Colors.white
                                : (enabled[i]
                                      ? CnColors.navy
                                      : CnColors.muted.withValues(alpha: 0.5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SaveIndicator extends StatelessWidget {
  const _SaveIndicator({required this.state, required this.onRetry});

  final SaveState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return switch (state) {
      SaveState.saving => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(l.cnSaving, style: const TextStyle(fontSize: 14)),
        ),
      ),
      SaveState.saved => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_done_outlined, size: 18),
              const SizedBox(width: 4),
              Text(l.cnSaved, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
      SaveState.failed => TextButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.sync_problem, color: CnColors.warn),
        label: Text(
          l.cnNotSavedRetry,
          style: const TextStyle(color: CnColors.warn),
        ),
      ),
      SaveState.idle => const SizedBox.shrink(),
    };
  }
}
