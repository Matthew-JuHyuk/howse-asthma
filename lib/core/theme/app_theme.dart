import 'package:flutter/material.dart';

/// Visual theme ported from Subframe `design/subframe/theme/tailwind.theme.js`
/// (brand teal / slate neutrals, 2026-07-25).
class AppTheme {
  AppTheme._();

  static const Color brand50 = Color(0xFFF0FDFA);
  static const Color brand100 = Color(0xFFCCFBF1);
  static const Color brand200 = Color(0xFF99F6E4);
  static const Color brand300 = Color(0xFF5EEAD4);
  static const Color brand400 = Color(0xFF2DD4BF);
  static const Color brand500 = Color(0xFF14B8A6);
  static const Color brand600 = Color(0xFF0F766E);
  static const Color brand700 = Color(0xFF115E59);
  static const Color brand800 = Color(0xFF134E4A);
  static const Color brand900 = Color(0xFF042F2E);
  static const Color brandPrimary = brand600;

  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  static const Color defaultBackground = neutral100;
  static const Color defaultFont = neutral900;
  static const Color subtext = neutral500;

  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFB91C1C);
  static const Color warning50 = Color(0xFFFFFBEB);
  static const Color warning200 = Color(0xFFFDE68A);
  static const Color warning500 = Color(0xFFF59E0B);
  static const Color warning600 = Color(0xFFD97706);
  static const Color warning700 = Color(0xFFB45309);
  static const Color warning800 = Color(0xFF92400E);
  static const Color success500 = Color(0xFF10B981);
  static const Color success600 = Color(0xFF059669);

  static const Color seedColor = brandPrimary;

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
      primary: brandPrimary,
      onPrimary: neutral0,
      secondary: brand500,
      surface: neutral0,
      onSurface: defaultFont,
      error: error500,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: defaultBackground,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: neutral0,
        foregroundColor: defaultFont,
        elevation: 0,
        scrolledUnderElevation: 0.5,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: neutral0,
        indicatorColor: brand100,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? brand700 : neutral500,
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: brandPrimary,
          foregroundColor: neutral0,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brand700,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: neutral300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutral0,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: brandPrimary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: neutral100,
        selectedColor: brand100,
        labelStyle: const TextStyle(color: neutral700, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      cardTheme: CardThemeData(
        color: neutral0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: neutral200),
        ),
      ),
    );
  }

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true),
      );
}
