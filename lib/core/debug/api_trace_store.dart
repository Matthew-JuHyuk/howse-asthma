import 'package:flutter/foundation.dart';

import 'api_trace_entry.dart';

/// In-memory ring buffer of Edge invokes (design §3). Not persisted.
class ApiTraceStore extends ValueNotifier<List<ApiTraceEntry>> {
  ApiTraceStore._() : super(const []);

  static final ApiTraceStore instance = ApiTraceStore._();

  static const int maxEntries = 100;

  void add(ApiTraceEntry entry) {
    final next = [entry, ...value];
    if (next.length > maxEntries) {
      value = next.sublist(0, maxEntries);
    } else {
      value = next;
    }
  }

  void clear() {
    value = const [];
  }
}
