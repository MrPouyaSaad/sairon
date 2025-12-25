import 'package:flutter/material.dart';

import '../../../../core/widgets/gradient.dart';

class EmptyAddresses extends StatelessWidget {
  final VoidCallback onAddAddress;

  const EmptyAddresses({super.key, required this.onAddAddress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: GradientTheme.accentGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_off_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 24),

            GradientText(
              'آدرسی ثبت نشده',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Text(
              'برای دریافت سفارشات خود نیاز به ثبت آدرس دارید',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: 200,
              child: GradientButton(
                text: 'افزودن آدرس جدید',
                onPressed: onAddAddress,
                expanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
