import 'package:flutter/material.dart';
import '../data/consent_repository.dart';
import '../data/preparation_repository.dart';
import '../domain/s9_models.dart';
import 'preparation_strings.dart';

class RecordTranslation extends StatefulWidget {
  const RecordTranslation({super.key, required this.eventId});
  final String eventId;
  @override
  State<RecordTranslation> createState() => _RecordTranslationState();
}

class _RecordTranslationState extends State<RecordTranslation> {
  String? _text, _error;
  bool _busy = false;
  Future<void> _translate() async {
    if (_busy) return;
    final repo = PreparationRepository();
    final owner = repo.uid;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final consent = ConsentRepository();
      if (!await consent.hasActive(ConsentPurpose.treatment)) {
        if (!mounted) return;
        final ok = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            content: Text(s10(c, 'consent')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: Text(s10(c, 'cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: Text(s10(c, 'confirm')),
              ),
            ],
          ),
        );
        if (ok != true) return;
        await consent.accept(ConsentPurpose.treatment);
      }
      if (!mounted || repo.uid != owner) return;
      final result = await repo.analyze(
        action: 'translate_record',
        input: {
          'event_id': widget.eventId,
          'language': Localizations.localeOf(context).toLanguageTag(),
        },
      );
      final value = (result['translation'] as Map?)?['text'];
      if (value is! String) throw StateError('translation_failed');
      if (mounted && repo.uid == owner) setState(() => _text = value);
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextButton.icon(
        onPressed: _busy ? null : _translate,
        icon: const Icon(Icons.translate),
        label: Text(s10(context, 'translateRecord')),
      ),
      if (_busy) const LinearProgressIndicator(),
      if (_error != null) Text(_error!),
      if (_text != null) SelectableText(_text!),
    ],
  );
}
