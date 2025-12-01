import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/gradient.dart';

class SplashContent extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;

  const SplashContent({
    super.key,
    required this.controller,
    required this.scaleAnimation,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> englishSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(-0.1, 0.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );

    final Animation<Offset> persianSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.1, 0.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );

    final Animation<double> lineFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
          ),
        );

    return Column(
      children: [
        // Logo
        ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: GradientTheme.accentGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF67E8F9).withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Image.asset('assets/images/sairon-logo.png'),
          ),
        ),

        const SizedBox(height: 32),

        // App name
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: persianSlideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: GradientText(
                  'ســــایــرون',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            FadeTransition(
              opacity: lineFadeAnimation,
              child: Container(
                width: 1,
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.backgroundColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            SlideTransition(
              position: englishSlideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: GradientText(
                  'SAIRON',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),

        const Gap(16),

        // Tagline
        FadeTransition(
          opacity: fadeAnimation,
          child: Text(
            'تجربه‌ای مدرن از خرید آنلاین',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              wordSpacing: -1,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
