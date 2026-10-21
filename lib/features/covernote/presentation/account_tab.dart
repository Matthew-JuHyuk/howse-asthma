import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/locale/language_picker.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/session/session_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../ui/brand.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  bool? _aiReady;
  bool _checking = false;
  bool _deleting = false;

  Future<void> _checkService() async {
    setState(() => _checking = true);
    final ok = await CoverNoteServices.of(context).live.analysisAvailable();
    if (mounted) {
      setState(() {
        _aiReady = ok;
        _checking = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    final l = AppLocalizations.of(context)!;
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l.cnDeleteAccountTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.cnDeleteAccountBody),
              const SizedBox(height: 12),
              TextField(
                controller: ctrl,
                autocorrect: false,
                decoration: InputDecoration(labelText: l.cnTypeDelete),
                onChanged: (_) => setLocal(() {}),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.cnCancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFA11D1D),
              ),
              onPressed: ctrl.text.trim() == 'DELETE'
                  ? () => Navigator.pop(ctx, true)
                  : null,
              child: Text(l.cnDeleteAccount),
            ),
          ],
        ),
      ),
    );
    ctrl.dispose();
    if (ok != true || !mounted) return;
    setState(() => _deleting = true);
    try {
      await SupabaseService.client.functions.invoke(
        'delete-account',
        body: {'confirm': 'DELETE'},
      );
      if (!mounted) return;
      await SessionScope.read(context).signOut();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.cnAccountDeleted)));
      }
    } on FunctionException {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.cnDeleteAccountFailed)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.cnErrNetwork)));
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = SessionScope.of(context);
    final locale = AppLocaleScope.of(context);
    final email = session.user?.email;
    return Scaffold(
      appBar: AppBar(title: Text(l.cnTabAccount)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          CnCard(
            child: session.isReady
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.profile!.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (email != null)
                        Text(
                          email,
                          style: const TextStyle(color: CnColors.muted),
                        ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: session.signOut,
                        icon: const Icon(Icons.logout),
                        label: Text(l.cnSignOut),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.cnAccountSignedOut,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: () => requireSignIn(context),
                        child: Text(l.cnAuthSignIn),
                      ),
                    ],
                  ),
          ),
          SectionLabel(l.cnLanguage),
          CnCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 12,
              leading: const Icon(Icons.language),
              title: Text(
                nativeNameOf(locale.value),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(l.cnLanguageNote),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showLanguagePicker(context),
            ),
          ),
          SectionLabel(l.cnServiceStatus),
          CnCard(
            child: Row(
              children: [
                Expanded(
                  child: Text(switch (_aiReady) {
                    true => l.cnServiceReady,
                    false => l.cnServiceUnavailableShort,
                    null => _checking ? l.cnChecking : l.cnServiceUnknown,
                  }),
                ),
                TextButton(
                  onPressed: _checking ? null : _checkService,
                  child: Text(l.cnCheck),
                ),
              ],
            ),
          ),
          SectionLabel(l.cnAbout),
          Text(l.cnAboutBody, style: const TextStyle(color: CnColors.muted)),
          if (session.isReady) ...[
            SectionLabel(l.cnDangerZone),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFA11D1D),
              ),
              onPressed: _deleting ? null : _deleteAccount,
              icon: _deleting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_forever_outlined),
              label: Text(l.cnDeleteAccount),
            ),
          ],
        ],
      ),
    );
  }
}
