import 'dart:async';

import 'package:flutter/material.dart';

import '../data/ai_extra_client.dart';
import '../ui/brand.dart';

/// Letter prose in the reader's language. Medicine names passed in [keep]
/// stay as printed. English UI shows the source. A failed translation
/// leaves the source on screen.
class TranslatedLine extends StatefulWidget {
  const TranslatedLine({
    super.key,
    required this.text,
    this.keep = const [],
    this.style,
  });

  final String text;
  final List<String> keep;
  final TextStyle? style;

  @override
  State<TranslatedLine> createState() => _TranslatedLineState();
}

class _TranslatedLineState extends State<TranslatedLine> {
  String? _shown;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _load();
    });
  }

  @override
  void didUpdateWidget(TranslatedLine old) {
    super.didUpdateWidget(old);
    if (old.text != widget.text) _load();
  }

  Future<void> _load() async {
    final lang = Localizations.localeOf(context).toLanguageTag();
    final text = await FieldTranslations.translate(
      language: lang,
      text: widget.text,
      keep: widget.keep,
    );
    if (mounted) setState(() => _shown = text);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _shown ?? widget.text,
      style:
          widget.style ??
          const TextStyle(fontSize: 16, height: 1.35, color: CnColors.ink),
    );
  }
}

class FieldTranslations {
  FieldTranslations._();

  static final _cache = <String, String>{};
  static final _wait = <String, List<Completer<String>>>{};
  static final _keep = <String, Set<String>>{};
  static Timer? _timer;
  static String? _language;

  static Future<String> translate({
    required String language,
    required String text,
    List<String> keep = const [],
  }) {
    final source = text.trim();
    if (source.isEmpty || language.toLowerCase().startsWith('en')) {
      return Future.value(text);
    }
    final key = '$language\n$source';
    final hit = _cache[key];
    if (hit != null) return Future.value(hit);
    final done = Completer<String>();
    _wait.putIfAbsent(key, () => []).add(done);
    _keep
        .putIfAbsent(key, () => {})
        .addAll(keep.where((k) => k.trim().isNotEmpty));
    _language = language;
    _timer ??= Timer(const Duration(milliseconds: 40), _flush);
    return done.future;
  }

  static Future<void> _flush() async {
    _timer = null;
    final language = _language;
    final batch = Map<String, List<Completer<String>>>.from(_wait);
    final keep = {for (final e in _keep.entries) e.key: e.value};
    _wait.clear();
    _keep.clear();
    if (language == null || batch.isEmpty) return;
    final texts = [
      for (final key in batch.keys) key.split('\n').skip(1).join('\n'),
    ];
    final tokens = {for (final set in keep.values) ...set}.toList();
    try {
      final out = await AiExtraClient().translateFields(
        language: language,
        texts: texts,
        keep: tokens,
      );
      var i = 0;
      for (final entry in batch.entries) {
        final value = i < out.length ? out[i] : texts[i];
        i++;
        _cache[entry.key] = value;
        for (final c in entry.value) {
          if (!c.isCompleted) c.complete(value);
        }
      }
    } catch (_) {
      var i = 0;
      for (final entry in batch.entries) {
        final value = texts[i++];
        for (final c in entry.value) {
          if (!c.isCompleted) c.complete(value);
        }
      }
    }
  }
}
