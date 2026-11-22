import 'package:flutter/material.dart';

import '../presentation/covernote_nav.dart';

/// A scrollable that opens at the top, including after a tab or screen change.
class StartAtTop extends StatefulWidget {
  const StartAtTop({super.key, required this.builder});

  final Widget Function(ScrollController controller) builder;

  @override
  State<StartAtTop> createState() => _StartAtTopState();
}

class _StartAtTopState extends State<StartAtTop> {
  final ScrollController controller = ScrollController();
  int? _token;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final token = CoverNoteNav.maybeOf(context)?.viewToken ?? 0;
    if (_token == token) return;
    _token = token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients && controller.offset > 0) {
        controller.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(controller);
}
