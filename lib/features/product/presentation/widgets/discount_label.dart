import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/gradient.dart';

class DiscountLabel extends StatelessWidget {
  const DiscountLabel({super.key, required this.discount});
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      top: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: GradientTheme.primaryGradient,
          borderRadius: Constants.primaryRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          '%$discount تخفیف',
          style: const TextStyle(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
