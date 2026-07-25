import 'package:flutter/material.dart';

import 'screen_ids.dart';
import 'screens/mock_screen_factory.dart';

/// Navigation helpers for design-preview mockups (no business logic).
class MockNav {
  MockNav._();

  static Future<T?> push<T>(BuildContext context, MockScreenId id) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(
        settings: RouteSettings(name: id.id),
        builder: (_) => MockScreenFactory.build(id),
      ),
    );
  }

  static void openCatalog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return ListView(
              controller: controller,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 4, 20, 12),
                  child: Text(
                    'Design preview screens',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                ...MockScreenId.all.map((id) {
                  return ListTile(
                    title: Text(id.label),
                    subtitle: Text(id.id),
                    trailing: const Icon(Icons.open_in_new, size: 18),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      push(context, id);
                    },
                  );
                }),
                const SizedBox(height: 24),
              ],
            );
          },
        );
      },
    );
  }
}
