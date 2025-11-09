// widgets/auth_footer.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'terms_dialog.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  void _showTermsDialog() {
    Get.dialog(
      const TermsDialog(),
      barrierDismissible: true,
      useSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: 'Yekan',
          ),
          children: [
            const TextSpan(text: 'با ورود یا ثبت‌نام در ســایـرون، '),
            TextSpan(
              text: 'شرایط و قوانین',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontFamily: 'Yekan',
              ),
              recognizer: TapGestureRecognizer()..onTap = _showTermsDialog,
            ),
            const TextSpan(text: ' را می‌پذیرید.'),
          ],
        ),
      ),
    );
  }
}
