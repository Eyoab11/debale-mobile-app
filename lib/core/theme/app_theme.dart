import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme Provider
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class AppTheme {
  // Main brand color from Dribbble reference
  static const Color primaryGold = Color(0xFFF6CB5A); // #F6CB5A
  static const Color secondaryDark = Color(0xFF222222); // For contrast
  static const Color accentBlue = Color(0xFF3A5A98); // Optional accent
  static const Color errorRed = Color(0xFFD32F2F);

  // Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryGold,
      secondary: accentBlue,
      tertiary: secondaryDark,
      surface: Colors.white,
      background: neutral50,
      error: errorRed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGold,
      foregroundColor: secondaryDark,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGold,
        foregroundColor: secondaryDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: neutral300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: neutral300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGold, width: 2),
      ),
      filled: true,
      fillColor: neutral50,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryGold,
      foregroundColor: secondaryDark,
    ),
    iconTheme: const IconThemeData(color: secondaryDark),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: secondaryDark),
      headlineMedium: TextStyle(color: secondaryDark),
      headlineSmall: TextStyle(color: secondaryDark),
      bodyLarge: TextStyle(color: secondaryDark),
      bodyMedium: TextStyle(color: secondaryDark),
      bodySmall: TextStyle(color: secondaryDark),
      labelLarge: TextStyle(color: secondaryDark),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryGold,
      secondary: accentBlue,
      tertiary: Colors.white,
      surface: neutral800,
      background: neutral900,
      error: errorRed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: neutral900,
      foregroundColor: primaryGold,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGold,
        foregroundColor: secondaryDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: neutral800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: neutral600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: neutral600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGold, width: 2),
      ),
      filled: true,
      fillColor: neutral800,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryGold,
      foregroundColor: secondaryDark,
    ),
    iconTheme: const IconThemeData(color: primaryGold),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: primaryGold),
    ),
  );
} 