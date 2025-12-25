import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';

class AppTextStyles {
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    wordSpacing: -2,
    color: AppColors.textPrimary,
    fontFamily: 'Yekan',
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Yekan',
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Yekan',
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 14,
    wordSpacing: -2,
    fontWeight: FontWeight.bold,
    fontFamily: 'Yekan',

    color: AppColors.textPrimary,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Yekan',
    wordSpacing: -2,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: 'Yekan',
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Yekan',
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: 'Yekan',
  );
}
