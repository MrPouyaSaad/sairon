import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/themes/text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Colors
      primaryColor: AppColors.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surface: AppColors.surfaceColor,
        background: AppColors.backgroundColor,
        error: AppColors.errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: Colors.white,
      ),

      // Typography
      fontFamily: 'Yekan',
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.headlineLarge,
        displayMedium: AppTextStyles.headlineMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        labelLarge: AppTextStyles.button,
        bodySmall: AppTextStyles.caption,
      ),

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceColor,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Yekan',
          color: AppColors.textPrimary,
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFe5e7eb)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFFe5e7eb),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
