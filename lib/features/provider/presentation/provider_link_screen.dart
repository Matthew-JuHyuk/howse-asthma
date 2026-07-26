import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/data/care_link_repository.dart';

/// SCR-PRV-LINK — issue invite codes and confirm pending care links.
class ProviderLinkScreen extends StatefulWidget {
  const ProviderLinkScreen({super.key});

  @override
  State<ProviderLinkScreen> createState() => _ProviderLinkScreenState();
}

class _ProviderLinkScreenState extends State<ProviderLinkScreen> {
  final _careLinks = CareLinkRepository();
  bool _loading = true;
  bool _issuing = false;
  String? _error;
  String? _latestCode;
  List<Map<String, dynamic>> _invites = [];
  List<Map<String, dynamic>> _links = [];

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final invites = await _careLinks.listMyInviteCodes();
      final links = await _careLinks.listMyCareLinks();
      if (!mounted) return;
      setState(() {
        _invites = invites;
        _links = links;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = AppLocalizations.of(context)!.authErrorGeneric;
        _loading = false;
      });
    }
  }

  Future<void> _issue() async {
    setState(() {
      _issuing = true;
      _error = null;
    });
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await _careLinks.issueInviteCode();
      final code = result['code'] as String?;
      setState(() => _latestCode = code);
      await _reload();
    } catch (_) {
      if (mounted) setState(() => _error = l10n.authInviteIssueFailed);
    } finally {
      if (mounted) setState(() => _issuing = false);
    }
  }

  Future<void> _confirm(String linkId, {required bool accept}) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _careLinks.confirmCareLink(linkId: linkId, accept: accept);
      await _reload();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authErrorGeneric)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pending = _links
        .where((l) => (l['status'] as String?) == 'pending')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.providerLinkTitle),
        actions: [
          IconButton(
            onPressed: _loading ? null : _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(l10n.providerLinkIntro),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _issuing ? null : _issue,
                    icon: const Icon(Icons.vpn_key_outlined),
                    label: Text(
                      _issuing
                          ? l10n.authWorking
                          : l10n.providerIssueInviteCta,
                    ),
                  ),
                  if (_latestCode != null) ...[
                    const SizedBox(height: 16),
                    Card(
                      child: ListTile(
                        title: Text(
                          _latestCode!,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        subtitle: Text(l10n.providerInviteTtlHint),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: _latestCode!),
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.providerInviteCopied)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    l10n.providerPendingLinks,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (pending.isEmpty)
                    Text(l10n.providerNoPendingLinks)
                  else
                    ...pending.map((link) {
                      final id = link['id'] as String;
                      final patientId = link['patient_id'] as String? ?? '';
                      final short = patientId.length > 8
                          ? patientId.substring(0, 8)
                          : patientId;
                      return Card(
                        child: ListTile(
                          title: Text(l10n.providerPendingPatient(short)),
                          subtitle: Text(l10n.authLinkStatusPending),
                          trailing: Wrap(
                            spacing: 4,
                            children: [
                              IconButton(
                                tooltip: l10n.authConfirmLink,
                                onPressed: () => _confirm(id, accept: true),
                                icon: const Icon(Icons.check_circle_outline),
                              ),
                              IconButton(
                                tooltip: l10n.authRejectLink,
                                onPressed: () => _confirm(id, accept: false),
                                icon: const Icon(Icons.cancel_outlined),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  const SizedBox(height: 24),
                  Text(
                    l10n.providerRecentInvites,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (_invites.isEmpty)
                    Text(l10n.providerNoInvites)
                  else
                    ..._invites.take(5).map((invite) {
                      final code = invite['code'] as String? ?? '';
                      final consumed = invite['consumed_at'] != null;
                      return ListTile(
                        dense: true,
                        title: Text(code),
                        subtitle: Text(
                          consumed
                              ? l10n.providerInviteConsumed
                              : l10n.providerInviteActive,
                        ),
                      );
                    }),
                ],
              ),
            ),
    );
  }
}
