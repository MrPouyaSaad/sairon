import 'package:flutter/material.dart';

class AppColors {
  // Colors from your CSS
  static const Color primaryColor = Color(0xFF1e40af);
  static const Color secondaryColor = Color(0xFF3b82f6);
  static const Color accentColor = Color(0xFFf97316);
  static const Color backgroundColor = Color(0xFFf9fafb);

  // Additional colors for app
  static const Color textPrimary = Color(0xFF1f2937);
  static const Color textSecondary = Color(0xFF6b7280);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFef4444);
  static const Color successColor = Color(0xFF10b981);
  static const Color warningColor = Color(0xFFf59e0b);

  // Gradient
  static const Gradient primaryGradient = LinearGradient(
    colors: [secondaryColor, accentColor],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}
