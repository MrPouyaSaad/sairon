import 'package:flutter/material.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onPressed});
  final String title;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Constants.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: AppTextStyles.button),
      ),
    );
  }
}
