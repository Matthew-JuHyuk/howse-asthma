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

  /// CoverNote teal, matched to the app icon.
  static const Color brandPrimary = Color(0xFF167D8D);

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

  /// Welcome / Direction C (Sprint 2) — slate navy canvas.
  static const Color welcomeBackground = Color(0xFF1E293B);
  static const Color welcomeOnBackground = neutral0;
  static const Color welcomeMuted = brand200;
  static const Color welcomeAccent = brand400;

  static const Color defaultBackground = Color(0xFFF3F6F8);
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
    const radius = 16.0;
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: defaultBackground,
      splashColor: brandPrimary.withValues(alpha: 0.08),
      highlightColor: brandPrimary.withValues(alpha: 0.04),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 26,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: Color(0xFF142D4E),
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: Color(0xFF142D4E),
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          height: 1.3,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
        ),
        bodyLarge: TextStyle(fontSize: 17, height: 1.45, color: defaultFont),
        bodyMedium: TextStyle(fontSize: 16, height: 1.45, color: defaultFont),
        bodySmall: TextStyle(fontSize: 14, height: 1.4, color: neutral600),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: neutral0,
        foregroundColor: defaultFont,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: defaultFont,
        ),
        shape: Border(bottom: BorderSide(color: neutral200)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 84,
        backgroundColor: neutral0,
        elevation: 10,
        shadowColor: const Color(0x1A142D4E),
        surfaceTintColor: Colors.transparent,
        indicatorColor: const Color(0xFFD8F2EC),
        indicatorShape: const StadiumBorder(),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? brand700 : neutral500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? brand700 : neutral500,
            size: 24,
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: brandPrimary,
          foregroundColor: neutral0,
          disabledBackgroundColor: neutral200,
          disabledForegroundColor: neutral500,
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brand700,
          backgroundColor: neutral0,
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          side: const BorderSide(color: Color(0xFFC5D4DC)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: brand700,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutral0,
        hintStyle: const TextStyle(color: neutral400),
        prefixIconColor: neutral500,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: brandPrimary, width: 1.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: neutral0,
        selectedColor: const Color(0xFFD8F2EC),
        disabledColor: neutral100,
        side: const BorderSide(color: neutral200),
        labelStyle: const TextStyle(
          color: neutral700,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      cardTheme: CardThemeData(
        color: neutral0,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: neutral200),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: neutral0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: defaultFont,
        ),
        contentTextStyle: const TextStyle(
          fontSize: 16,
          height: 1.4,
          color: neutral700,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: neutral800,
        contentTextStyle: const TextStyle(fontSize: 15, color: neutral0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: neutral0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: brandPrimary,
        linearTrackColor: Color(0xFFD8F2EC),
        circularTrackColor: Color(0xFFD8F2EC),
        borderRadius: BorderRadius.all(Radius.circular(99)),
      ),
      dividerTheme: const DividerThemeData(
        color: neutral200,
        space: 1,
        thickness: 1,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: brandPrimary,
        textColor: defaultFont,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: defaultFont,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          side: const WidgetStatePropertyAll(BorderSide(color: neutral200)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? neutral0 : neutral400,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? brandPrimary : neutral200,
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
