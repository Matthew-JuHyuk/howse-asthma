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
import 'routes.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    final uid = s.isReady ? s.user?.id : null;
    if (uid != _loadedFor) {
      _loadedFor = uid;
      _cases = null;
      if (uid != null) refresh();
    }
  }

  Future<void> refresh() async {
    if (_loadedFor == null) return;
    try {
      final list = await CoverNoteServices.of(context).live.listCases();
      if (!mounted) return;
      setState(() {
        _cases = list;
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
    final active = cases.where((c) => c.row.status != 'deleting').toList();
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
              l.cnHomeHeadline,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: CnColors.navy,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 64,
              child: FilledButton.icon(
                onPressed: () => _start(CaptureSource.camera),
                icon: const Icon(Icons.document_scanner_outlined, size: 28),
                label: Text(
                  l.cnScanLetter,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => _start(CaptureSource.files),
                icon: const Icon(Icons.upload_file_outlined),
                label: Text(
                  l.cnUploadFile,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              child: TextButton.icon(
                onPressed: () => openDemo(context),
                icon: const Icon(Icons.play_circle_outline, size: 20),
                label: Text(l.cnTryDemo),
              ),
            ),
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
              SectionLabel(l.cnContinueCase),
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
            SectionLabel(l.cnHowItWorks),
            _Steps(),
            if (signedIn) ...[
              SectionLabel(l.cnRecentCases),
              if (_error != null)
                ActionMessage(
                  icon: Icons.cloud_off,
                  title: l.cnErrNetwork,
                  actionLabel: l.cnRetry,
                  onAction: refresh,
                )
              else if (_cases == null)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (active.length <= 1)
                Text(
                  active.isEmpty ? l.cnNoCasesYet : l.cnNoOtherCases,
                  style: const TextStyle(color: CnColors.muted),
                )
              else ...[
                for (final c in active.skip(1).take(3)) ...[
                  CaseCard(
                    summary: c,
                    onTap: () async {
                      await openCase(
                        context,
                        CoverNoteServices.of(context).live,
                        c.row.id,
                      );
                      if (mounted) await refresh();
                    },
                  ),
                  const SizedBox(height: 8),
                ],
                if (active.length > 4)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: widget.onOpenCases,
                      child: Text(l.cnSeeAllCases),
                    ),
                  ),
              ],
            ],
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
