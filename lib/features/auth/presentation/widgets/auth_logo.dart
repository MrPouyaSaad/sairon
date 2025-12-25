// widgets/auth_logo.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/themes/app_colors.dart';

class AuthLogo extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthLogo({
    super.key,
    this.title = 'به جمع همراهان ســایـرون خوش آمدید',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            // gradient: GradientTheme.buttonGradient,
            // borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Image.asset('assets/images/sairon-logo.png'),
        ),

        Gap(16),

        Text(
          title,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),

        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ],
    );
  }
}
