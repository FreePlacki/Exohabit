import 'package:flutter/material.dart';

const _spaceBlack = Color(0xFF0B0E14);
const _surfaceDark = Color(0xFF131825);
const _surfaceVariant = Color(0xFF1A2032);

const _purplePrimary = Color(0xFF8B7CFF);
const _purpleSecondary = Color(0xFFB4A9FF);
const _purpleAccent = Color(0xFFC6BFFF);

const _errorRed = Color(0xFFFF6B6B);

ThemeData buildExoplanetTheme() {
  const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    surfaceTint: Colors.transparent,
    primary: _purplePrimary,
    onPrimary: Colors.black,
    secondary: _purpleSecondary,
    onSecondary: Colors.black,
    tertiary: _purpleAccent,
    onTertiary: Colors.black,
    error: _errorRed,
    onError: Colors.black,
    surface: _spaceBlack,
    onSurface: Colors.white,
    surfaceContainerHighest: _surfaceVariant,
    onSurfaceVariant: Colors.white70,
    surfaceContainer: _surfaceDark,
    onInverseSurface: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainerHighest,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceVariant,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _purplePrimary, width: 2),
      ),
      hintStyle: const TextStyle(color: Colors.white70),
      labelStyle: const TextStyle(color: Colors.white70),
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white70,
      textColor: Colors.white,
    ),

    iconTheme: const IconThemeData(color: Colors.white70, size: 22),

    dividerTheme: DividerThemeData(
      color: Colors.white.withValues(alpha: 0.06),
      thickness: 1,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: _surfaceDark,
      selectedColor: _purplePrimary.withValues(alpha: 0.25),
      labelStyle: const TextStyle(color: Colors.white),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _purplePrimary,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        _purplePrimary.withValues(alpha: 0.6),
      ),
      radius: const Radius.circular(8),
      thickness: WidgetStateProperty.all(6),
    ),
  );
}
