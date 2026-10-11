import 'package:flutter/foundation.dart';

/// Bumped after any record write so Home, My log, and Visit prep reload the
/// same data instead of keeping their own copies.
class RecordsRevision extends ValueNotifier<int> {
  RecordsRevision._() : super(0);

  static final instance = RecordsRevision._();

  void bump() => value++;
}
