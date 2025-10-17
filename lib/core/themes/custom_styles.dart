import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/themes/text_styles.dart';

class AppCustomStyles {
  // Section Title with gradient underline (like your CSS)
  static TextStyle sectionTitle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold);
  }

  // Card style matching your CSS
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.surfaceColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Category card style
  static BoxDecoration categoryCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: AppColors.primaryGradient,
  );

  // Button styles matching your CSS
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: AppTextStyles.button,
  );

  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryColor,
    side: const BorderSide(color: AppColors.primaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: AppTextStyles.button.copyWith(color: AppColors.primaryColor),
  );

  // Horizontal scroll container
  static BoxDecoration horizontalScrollContainer = BoxDecoration(
    color: AppColors.backgroundColor,
  );
}

// Extension for easy access
extension CustomTheme on ThemeData {
  TextStyle get sectionTitle =>
      textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold);

  BoxDecoration get cardDecoration => BoxDecoration(
    color: colorScheme.surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
