import 'package:flutter/material.dart';

import '../../../../core/widgets/gradient.dart';

class EmptyProductsList extends StatelessWidget {
  const EmptyProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: GradientTheme.accentGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: Colors.white,
                size: 64,
              ),
            ),

            const SizedBox(height: 32),

            GradientText(
              'محصولی یافت نشد!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(
              'در این دسته‌بندی محصولی برای نمایش وجود ندارد!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
