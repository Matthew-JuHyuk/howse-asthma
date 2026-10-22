import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase_service.dart';
import '../domain/s9_models.dart';

/// Extra analyze-letter actions: full-page translation and medication labels.
/// Both require the matching consent and the same AI secrets as letter reading.
class AiExtraClient {
  Future<List<PageTranslation>> translateCase({
    required String caseId,
    required String language,
    required int documentRevision,
  }) async {
    final d = await _invoke({
      'action': 'translate',
      'case_id': caseId,
      'language': language,
      'document_revision': documentRevision,
    });
    final pages = d['pages'];
    if (pages is! List) return const [];
    return [
      for (final p in pages)
        if (p is Map)
          PageTranslation(
            pageNumber: (p['page'] as num?)?.toInt() ?? 0,
            status: p['status'] as String? ?? 'failed',
            text: p['text'] as String?,
          ),
    ];
  }

  Future<List<PageTranslation>> loadCachedTranslation({
    required String caseId,
    required String language,
    required int documentRevision,
  }) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return const [];
    try {
      final rows = await SupabaseService.client
          .from('document_translations')
          .select('page_number, status, translated_text')
          .eq('case_id', caseId)
          .eq('language', language)
          .eq('document_revision', documentRevision)
          .order('page_number');
      return [
        for (final r in rows as List)
          PageTranslation(
            pageNumber: (r['page_number'] as num).toInt(),
            status: r['status'] as String,
            text: r['translated_text'] as String?,
          ),
      ];
    } catch (_) {
      return const [];
    }
  }

  /// One in-flight full-letter translation per case, language and revision.
  static final _full = <String, Future<List<PageTranslation>>>{};

  Future<List<PageTranslation>> ensureFullTranslation({
    required String caseId,
    required String language,
    required int documentRevision,
  }) {
    if (language.toLowerCase().startsWith('en')) return Future.value(const []);
    final key = '$caseId|$language|$documentRevision';
    return _full[key] ??= translateCase(
      caseId: caseId,
      language: language,
      documentRevision: documentRevision,
    ).whenComplete(() => _full.remove(key));
  }

  Future<List<String>> translateFields({
    required String language,
    required List<String> texts,
    List<String> keep = const [],
  }) async {
    final res = await _invoke({
      'action': 'translate_fields',
      'language': language,
      'texts': texts,
      'keep': keep,
    });
    final items = res['items'];
    if (items is! List) return texts;
    return [
      for (var i = 0; i < texts.length; i++)
        i < items.length && items[i] is String && (items[i] as String).trim().isNotEmpty
            ? items[i] as String
            : texts[i],
    ];
  }

  Future<Map<String, dynamic>> _invoke(Map<String, dynamic> body) async {
    try {
      final res = await SupabaseService.client.functions.invoke(
        'analyze-letter',
        body: body,
      );
      final d = res.data;
      if (d is! Map) throw StateError('translate_failed');
      if (d['error'] != null) throw StateError(d['error'].toString());
      return Map<String, dynamic>.from(d);
    } on FunctionException catch (e) {
      final d = e.details;
      final code = d is Map && d['error'] is String
          ? d['error'] as String
          : 'http_${e.status}';
      throw StateError(code);
    }
  }

  Future<LabelExtract> readLabel(Uint8List bytes, String mime) async {
    final res = await SupabaseService.client.functions.invoke(
      'analyze-letter',
      body: {
        'action': 'read_label',
        'mime': mime,
        'image_base64': base64Encode(bytes),
      },
    );
    final d = res.data;
    if (d is! Map) throw StateError('label_failed');
    if (d['error'] != null) throw StateError(d['error'].toString());
    return LabelExtract(
      name: _emptyToNull(d['name'] as String?),
      strength: _emptyToNull(d['strength'] as String?),
      form: _emptyToNull(d['form'] as String?),
      directions: _emptyToNull(d['directions'] as String?),
      unclear: [
        for (final x in (d['unclear'] as List? ?? const []))
          if (x is String) x,
      ],
      needsLabelPhoto: d['needs_label_photo'] == true,
    );
  }

  String? _emptyToNull(String? s) {
    final t = s?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }
}
