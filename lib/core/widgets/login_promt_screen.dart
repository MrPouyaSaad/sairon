import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/pages/auth_bloc_wrapper.dart';

class LoginPromtScreen extends StatelessWidget {
  const LoginPromtScreen({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login-promt.jpg',
              height: 250,
              width: 250,
              fit: BoxFit.contain,
            ),
            Gap(16),

            Text(
              'ورود به حساب کاربری',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                wordSpacing: -1,
                color: Colors.grey[800],
              ),
            ),

            Gap(16),

            Text(
              description,
              textAlign: TextAlign.center,

              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                wordSpacing: -1,
                height: 1.5,
              ),
            ),

            Gap(32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to login page
                  Get.to(
                    () => const AuthWrapper(),
                    arguments: {'returnTo': Get.currentRoute},
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'ورود / ثبت نام',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Gap(16),
          ],
        ),
      ),
    );
  }
}
