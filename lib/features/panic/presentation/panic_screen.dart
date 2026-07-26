import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/location/location_service.dart';
import '../../../core/phone/phone_e164.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../settings/data/emergency_contact_repository.dart';
import '../data/panic_repository.dart';

/// SCR-SYS-PANIC — Step1 breathe/inhaler, Step2 tel: (no auto-dial).
class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  final _panicRepo = PanicRepository();
  final _inhalerRepo = InhalerEventRepository();
  final _contactRepo = EmergencyContactRepository();
  final _location = const LocationService();

  int _step = 1;
  String? _episodeId;
  String? _contactPhone;
  String? _contactName;
  bool _busy = false;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    if (!_completed && _episodeId != null) {
      // Best-effort close without awaiting (widget disposing).
      _panicRepo.complete(
        episodeId: _episodeId!,
        outcomeChip: 'dismissed',
      );
    }
    super.dispose();
  }

  Future<void> _bootstrap() async {
    try {
      final episode = await _panicRepo.startEpisode();
      final contact = await _contactRepo.get();
      if (!mounted) return;
      setState(() {
        _episodeId = episode['id'] as String?;
        final phone = contact?['phone_e164'] as String?;
        _contactPhone = phone != null && PhoneE164.isValid(phone) ? phone : null;
        _contactName = contact?['display_name'] as String?;
      });
    } catch (_) {}
  }

  Future<void> _logInhaler() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final loc = await _location.getCurrentPosition();
      final event = await _inhalerRepo.logUse(
        latitude: loc.position?.latitude,
        longitude: loc.position?.longitude,
        isPanic: true,
      );
      final eventId = event['id'] as String?;
      if (_episodeId != null && eventId != null) {
        await _panicRepo.linkInhalerEvent(
          episodeId: _episodeId!,
          inhalerEventId: eventId,
        );
      }
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.oneTapLoggedOk)),
      );
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.oneTapLoggedFailed)),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _dial(String raw) async {
    final l10n = AppLocalizations.of(context)!;
    final sanitized = raw == '911'
        ? '911'
        : PhoneE164.normalize(raw);
    if (sanitized == null && raw != '911') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.panicDialFailed)),
      );
      return;
    }
    final uri = Uri.parse('tel:${sanitized ?? raw}');
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.panicDialFailed)),
      );
      return;
    }
    if (_episodeId != null) {
      try {
        await _panicRepo.markHelpRequested(_episodeId!);
      } catch (_) {}
    }
  }

  Future<void> _feelingBetter() async {
    if (_episodeId != null) {
      try {
        await _panicRepo.complete(
          episodeId: _episodeId!,
          outcomeChip: 'feeling_better',
        );
      } catch (_) {}
    }
    _completed = true;
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bg = _step == 1 ? AppTheme.error600 : AppTheme.neutral900;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop && !_completed && _episodeId != null) {
          _completed = true;
          try {
            await _panicRepo.complete(
              episodeId: _episodeId!,
              outcomeChip: 'dismissed',
            );
          } catch (_) {}
        }
      },
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _step == 1 ? _step1(l10n) : _step2(l10n),
          ),
        ),
      ),
    );
  }

  Widget _step1(AppLocalizations l10n) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'SCR-SYS-PANIC',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            l10n.panicEmergencyBadge,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Spacer(),
        const Icon(Icons.air, size: 72, color: Colors.white),
        const SizedBox(height: 16),
        Text(
          l10n.panicBreatheTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.mockPanicStep1Body,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Spacer(),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.error600,
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: _busy ? null : _logInhaler,
          child: Text(l10n.panicTakeInhalerNow),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => setState(() => _step = 2),
          child: Text(
            l10n.panicNeedHelp,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _step2(AppLocalizations l10n) {
    final contactLabel = _contactName == null || _contactName!.isEmpty
        ? l10n.mockCallGuardian
        : l10n.panicCallNamed(_contactName!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.mockPanicStep2Title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.panicNoAutoDial,
          style: const TextStyle(color: Colors.white70),
        ),
        const Spacer(),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.error600,
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: () => _dial('911'),
          child: Text(l10n.mockCall911),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: _contactPhone == null ? null : () => _dial(_contactPhone!),
          child: Text(contactLabel),
        ),
        const Spacer(),
        TextButton(
          onPressed: _feelingBetter,
          child: Text(
            l10n.mockFeelingBetter,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
