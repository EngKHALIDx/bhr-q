import 'package:flutter/material.dart';
import 'constants.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(AppConstants.primaryColorValue),
    scaffoldBackgroundColor: const Color(0xFFF8FAFB),
    fontFamily: 'Cairo',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(AppConstants.primaryColorValue),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(AppConstants.primaryColorValue),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
      unselectedLabelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 10, fontWeight: FontWeight.w500),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(AppConstants.primaryColorValue),
      secondary: Color(AppConstants.accentGoldValue),
      error: Color(AppConstants.errorColorValue),
      surface: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(AppConstants.primaryColorValue),
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: 'Cairo',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(AppConstants.accentGoldValue),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
      unselectedLabelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(
          fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          fontFamily: 'Cairo', fontSize: 10, fontWeight: FontWeight.w500),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(AppConstants.primaryColorValue),
      secondary: Color(AppConstants.accentGoldValue),
      error: Color(AppConstants.errorColorValue),
      surface: Color(0xFF1E1E1E),
    ),
  );
}
