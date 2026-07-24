import 'package:flutter/material.dart';

/// Shared visual theme for the app. Uses a calm, accessible blue/teal
/// palette that works well for a health-focused, multilingual audience.
class AppTheme {
  AppTheme._();

  static const Color seedColor = Color(0xFF2E7D8F);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true),
      );
}
