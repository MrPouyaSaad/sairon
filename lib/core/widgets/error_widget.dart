import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/themes/text_styles.dart';
import 'package:sairon/core/widgets/custom_button.dart';
import 'package:gap/gap.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });
  final String message;
  final Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: AppColors.textSecondary),
            Gap(24),
            Text(
              message,
              style: AppTextStyles.errorText,
              textAlign: TextAlign.center,
            ),
            Gap(24),
            CustomButton(title: 'تلاش مجدد', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
