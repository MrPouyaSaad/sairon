// gradient_app_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:sairon/core/widgets/gradient.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Color>? gradientColors;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Gradient? gradient;
  final double textSize;
  const GradientAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.gradientColors,
    this.textColor,
    this.borderRadius,
    this.textSize = 24,
    this.padding,
    this.height = 140,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      height: height,
      padding:
          padding ??
          const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
      decoration: BoxDecoration(
        gradient: gradient ?? GradientTheme.buttonGradient,
        borderRadius:
            borderRadius ??
            const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
      ),
      child: Row(
        children: [
          // Back Button
          if (showBackButton) ...[
            _buildBackButton(context, colors),
            const SizedBox(width: 16),
          ],
          if (leading != null) ...[leading!, const SizedBox(width: 16)],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w800,
                color: textColor ?? colors.onPrimary,
              ),
            ),
          ),
          ...?actions,
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, ColorScheme colors) {
    return Container(
      decoration: BoxDecoration(
        color: (textColor ?? colors.onPrimary).withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: textColor ?? colors.onPrimary),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
    );
  }
}
