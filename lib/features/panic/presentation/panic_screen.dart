import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-SYS-PANIC — combined Step 1 (breathe / inhaler) + Step 2 (call for help).
/// Step 2 is `tel:`-intent only in production; this stub shows a SnackBar.
/// **No auto-dial.**
class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  int _step = 1;

  void _dialStub(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label — opens tel: on device (no auto-dial)'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bg = _step == 1 ? AppTheme.error600 : AppTheme.neutral900;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _step == 1 ? _step1(l10n) : _step2(l10n),
        ),
      ),
    );
  }

  Widget _step1(AppLocalizations l10n) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('SCR-SYS-PANIC', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(99)),
          child: const Text('EMERGENCY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ),
        const Spacer(),
        const Icon(Icons.air, size: 72, color: Colors.white),
        const SizedBox(height: 16),
        const Text(
          'Breathe & Use Inhaler',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.mockPanicStep1Body,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(height: 8),
        const Text('4 seconds in — 4 seconds out', style: TextStyle(color: Colors.white70)),
        const Spacer(),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.error600,
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: () {},
          child: const Text('Take Inhaler Now'),
        ),
        const SizedBox(height: 12),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white24,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: () => setState(() => _step = 2),
          child: Text(l10n.mockPanicStep2Title),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.mockDismiss, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _step2(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('SCR-SYS-PANIC · Step 2', style: TextStyle(color: AppTheme.neutral400, fontSize: 12)),
        const SizedBox(height: 8),
        const Text(
          'EMERGENCY',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.error500, fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
        const Spacer(),
        Text(
          l10n.mockPanicStep2Title,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tap to place a phone call. This app does not auto-dial.',
          style: TextStyle(color: AppTheme.warning500, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 28),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.error500,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: () => _dialStub(l10n.mockCall911),
          icon: const Icon(Icons.call),
          label: Text(l10n.mockCall911),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: AppTheme.neutral500),
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: () => _dialStub(l10n.mockCallGuardian),
          icon: const Icon(Icons.contact_phone_outlined),
          label: Text(l10n.mockCallGuardian),
        ),
        const SizedBox(height: 8),
        const Text(
          'Phone call only · No SMS / push / email from this screen',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.neutral400, fontSize: 12),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.mockFeelingBetter, style: const TextStyle(color: AppTheme.brand300)),
        ),
        TextButton(
          onPressed: () => setState(() => _step = 1),
          child: const Text('Back to breathe', style: TextStyle(color: AppTheme.neutral400)),
        ),
      ],
    );
  }
}
