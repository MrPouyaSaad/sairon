import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/themes/app_colors.dart';

class RateSection extends StatelessWidget {
  const RateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
        ).marginSymmetric(horizontal: 16),
        MaxGap(1000),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "(124)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  fontFamily: 'Yekan',
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: " 4.5",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Yekan',
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Gap(8),
        Icon(Iconsax.star5, color: Colors.amber, size: 22),
        Gap(24),
      ],
    );
  }
}
