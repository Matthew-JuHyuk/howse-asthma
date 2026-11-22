import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'preparation_strings.dart';

/// Four destinations with one central action; the microphone is never a tab.
class RecordNavigationBar extends StatelessWidget {
  const RecordNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestination,
    required this.onRecord,
  });
  final int selectedIndex;
  final ValueChanged<int> onDestination;
  final VoidCallback? onRecord;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return NavigationBar(
      height: 84,
      selectedIndex: selectedIndex < 2 ? selectedIndex : selectedIndex + 1,
      onDestinationSelected: (i) {
        if (i == 2) {
          onRecord?.call();
        } else {
          onDestination(i < 2 ? i : i - 1);
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: l.cnTabHome,
        ),
        NavigationDestination(
          icon: const Icon(Icons.folder_outlined),
          selectedIcon: const Icon(Icons.folder),
          label: l.cnTabCases,
        ),
        NavigationDestination(
          enabled: onRecord != null,
          icon: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2AA3B5), Color(0xFF0E6674)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.32),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.mic_rounded, color: Colors.white, size: 26),
          ),
          label: s10(context, 'recordEntry'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.calendar_month_outlined),
          selectedIcon: const Icon(Icons.calendar_month),
          label: l.cnTabRecords,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: l.cnTabSettings,
        ),
      ],
    );
  }
}
