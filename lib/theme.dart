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

    primary: _purplePrimary,
    onPrimary: Colors.black,

    secondary: _purpleSecondary,
    onSecondary: Colors.black,

    tertiary: _purpleAccent,
    onTertiary: Colors.black,

    error: _errorRed,
    onError: Colors.black,

    surface: _surfaceDark,
    onSurface: Colors.white,

    surfaceContainerHighest: _surfaceVariant,
    onSurfaceVariant: Colors.white70,

    surfaceContainer: _spaceBlack,
    onInverseSurface: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: _spaceBlack,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainerHighest,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Lists
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white70,
      textColor: Colors.white,
    ),

    // Icons
    iconTheme: const IconThemeData(
      color: Colors.white70,
      size: 22,
    ),

    // Dividers
    dividerTheme: DividerThemeData(
      color: Colors.white.withOpacity(0.06),
      thickness: 1,
    ),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: _surfaceDark,
      selectedColor: _purplePrimary.withOpacity(0.25),
      labelStyle: const TextStyle(color: Colors.white),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Text
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),

    // Floating Action Button (if you add one later)
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _purplePrimary,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    // Scrollbars (desktop/web)
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        _purplePrimary.withValues(alpha: 0.6),
      ),
      radius: const Radius.circular(8),
      thickness: WidgetStateProperty.all(6),
    ),
  );
}
