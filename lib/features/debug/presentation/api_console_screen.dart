import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/debug/api_trace_entry.dart';
import '../../../core/debug/api_trace_store.dart';
import '../../../core/debug/debug_gates.dart';
import '../../../core/debug/debug_redactor.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-SYS-DEBUG — Edge invoke timeline (debug/profile + DEBUG_API_CONSOLE only).
class ApiConsoleScreen extends StatefulWidget {
  const ApiConsoleScreen({super.key});

  @override
  State<ApiConsoleScreen> createState() => _ApiConsoleScreenState();
}

enum _TraceFilter { all, calculate, notify, log, invite }

class _ApiConsoleScreenState extends State<ApiConsoleScreen> {
  static const int _jsonTruncateChars = 50000;

  _TraceFilter _filter = _TraceFilter.all;
  bool _roundCoordinates = true;
  ApiTraceEntry? _selected;

  List<ApiTraceEntry> _filtered(List<ApiTraceEntry> all) {
    return all.where((e) {
      switch (_filter) {
        case _TraceFilter.all:
          return true;
        case _TraceFilter.calculate:
          return e.name.contains('calculate');
        case _TraceFilter.notify:
          return e.name.contains('notify');
        case _TraceFilter.log:
          return e.name.contains('log-inhaler');
        case _TraceFilter.invite:
          return e.name.contains('invite') || e.name.contains('care-link');
      }
    }).toList();
  }

  Map<String, dynamic> _displayRequest(ApiTraceEntry e) {
    return DebugRedactor.scrub(
      e.requestBody,
      roundCoordinates: _roundCoordinates,
    );
  }

  Map<String, dynamic>? _displayResponse(ApiTraceEntry e) {
    return DebugRedactor.scrubOrNull(
      e.responseBody,
      roundCoordinates: _roundCoordinates,
    );
  }

  String _prettyJson(Object? value) {
    try {
      final encoded = const JsonEncoder.withIndent('  ').convert(value);
      if (encoded.length > _jsonTruncateChars) {
        return '${encoded.substring(0, _jsonTruncateChars)}\n…[truncated]';
      }
      return encoded;
    } catch (_) {
      return value.toString();
    }
  }

  Future<void> _copy(String label, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copied')),
    );
  }

  String _metricsLine(ApiTraceEntry e) {
    if (e.metrics.isEmpty) return e.stableError ?? '';
    return e.metrics.entries.map((kv) => '${kv.key}=${kv.value}').join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    if (!DebugGates.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return const Scaffold(
        body: Center(child: Text('API Console disabled')),
      );
    }

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: const Text('API Console'),
        backgroundColor: AppTheme.defaultBackground,
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed: () {
              ApiTraceStore.instance.clear();
              setState(() => _selected = null);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<ApiTraceEntry>>(
          valueListenable: ApiTraceStore.instance,
          builder: (context, entries, _) {
            final list = _filtered(entries);
            if (_selected != null) {
              final still =
                  entries.where((e) => e.id == _selected!.id).toList();
              if (still.isEmpty) {
                // Evicted from ring buffer — drop orphan detail (no PHI retain).
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) setState(() => _selected = null);
                });
                return const Center(child: Text('Trace expired'));
              }
              return _buildDetail(l10n, still.first);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: AppTheme.warning50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Text(
                      l10n.debugApiConsoleBanner,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warning800,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final f in _TraceFilter.values)
                        FilterChip(
                          label: Text(_filterLabel(f)),
                          selected: _filter == f,
                          onSelected: (_) => setState(() => _filter = f),
                        ),
                    ],
                  ),
                ),
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: const Text('Round lat/lon (3 decimals)'),
                  value: _roundCoordinates,
                  onChanged: (v) => setState(() => _roundCoordinates = v),
                ),
                Expanded(
                  child: list.isEmpty
                      ? const Center(
                          child: Text(
                            'No Edge invokes recorded yet.\nTrigger risk, notify, log, or invite.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.neutral400),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                          itemCount: list.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (context, i) {
                            final e = list[i];
                            final status = e.stableError ??
                                (e.statusCode?.toString() ?? '—');
                            final time =
                                '${e.at.hour.toString().padLeft(2, '0')}:'
                                '${e.at.minute.toString().padLeft(2, '0')}:'
                                '${e.at.second.toString().padLeft(2, '0')}';
                            return Material(
                              color: AppTheme.neutral0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: AppTheme.neutral200,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => setState(() => _selected = e),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${e.elapsedMs}ms  ${e.name}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '$status · $time',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.neutral400,
                                        ),
                                      ),
                                      if (_metricsLine(e).isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          _metricsLine(e),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _filterLabel(_TraceFilter f) {
    switch (f) {
      case _TraceFilter.all:
        return 'All';
      case _TraceFilter.calculate:
        return 'calculate';
      case _TraceFilter.notify:
        return 'notify';
      case _TraceFilter.log:
        return 'log';
      case _TraceFilter.invite:
        return 'invite';
    }
  }

  Widget _buildDetail(AppLocalizations l10n, ApiTraceEntry e) {
    final req = _prettyJson(_displayRequest(e));
    final displayRes = _displayResponse(e);
    final res = _prettyJson(
      displayRes ??
          {'stableError': e.stableError, 'statusCode': e.statusCode},
    );
    final metricsJson = _prettyJson(e.metrics);
    final fullJson = _prettyJson({
      'name': e.name,
      'at': e.at.toIso8601String(),
      'elapsedMs': e.elapsedMs,
      'statusCode': e.statusCode,
      'stableError': e.stableError,
      'fromCache': e.fromCache,
      'degraded': e.degraded,
      'metrics': e.metrics,
      'request': _displayRequest(e),
      'response': displayRes,
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: AppTheme.warning50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              l10n.debugApiConsoleBanner,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.warning800,
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.arrow_back),
          title: Text(e.name),
          subtitle: Text(
            '${e.elapsedMs} ms · ${e.statusCode ?? "—"} · '
            '${e.at.toLocal()}',
          ),
          onTap: () => setState(() => _selected = null),
        ),
        if (e.metrics.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: e.metrics.entries
                  .map(
                    (kv) => Chip(
                      label: Text('${kv.key}=${kv.value}'),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => _copy('Metrics', metricsJson),
                child: const Text('Copy metrics'),
              ),
              OutlinedButton(
                onPressed: () => _copy('JSON', fullJson),
                child: const Text('Copy JSON'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: [
              const Text(
                'Request',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              SelectableText(
                req,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              const SizedBox(height: 16),
              const Text(
                'Response',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              SelectableText(
                res,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
