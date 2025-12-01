import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background circles
        Positioned(
          top: -30,
          right: -30,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF67E8F9).withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -60,
          left: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFD8B4FE).withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Simple floating particles
        ...List.generate(6, (index) {
          final size = 3.0 + (index % 2) * 2.0;
          return Positioned(
            left: (index * 60.0) % MediaQuery.of(context).size.width,
            top: (80 + index * 80.0) % MediaQuery.of(context).size.height,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: index.isEven
                    ? const Color(0xFF67E8F9).withOpacity(0.4)
                    : const Color(0xFFD8B4FE).withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ],
    );
  }
}
