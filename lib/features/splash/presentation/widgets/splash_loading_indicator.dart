import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/features/splash/presentation/bloc/splash_bloc.dart';

import '../../../../core/widgets/gradient.dart';

class SplashLoadingIndicator extends StatelessWidget {
  final AnimationController controller;

  const SplashLoadingIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        if (controller.status != AnimationStatus.completed) {
          return _buildInitialLoading();
        }

        return _buildStateBasedLoading(state, context);
      },
    );
  }

  Widget _buildInitialLoading() {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          // Progress bar
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(1),
            ),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Container(
                  height: 2,
                  width: 100 * controller.value,
                  decoration: BoxDecoration(
                    gradient: GradientTheme.accentGradient,
                    borderRadius: BorderRadius.circular(1),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'در حال بارگذاری',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              _buildSimpleDots(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStateBasedLoading(SplashState state, BuildContext context) {
    final loadingData = _getLoadingData(state);
    return Column(
      children: [
        if (loadingData.showError)
          Icon(Icons.error_outline, color: Colors.orange[300], size: 20),
        if (loadingData.showError) const SizedBox(height: 6),
        SizedBox(
          width: 100,
          child: Column(
            children: [
              // Progress bar
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Container(
                  height: 2,
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: loadingData.progressGradient,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                loadingData.text,
                style: TextStyle(color: loadingData.textColor, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              if (loadingData.showRetry) const SizedBox(height: 12),
              if (loadingData.showRetry)
                GradientButton(
                  onPressed: () {
                    BlocProvider.of<SplashBloc>(
                      context,
                    ).add(CheckInitialData());
                  },
                  text: 'تلاش مجدد',
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleDots() {
    return Row(
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final delay = index * 0.3;
            final opacity = (controller.value - delay).clamp(0.0, 1.0);
            return Opacity(opacity: opacity, child: child);
          },
          child: Text(
            '.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }

  _LoadingData _getLoadingData(SplashState state) {
    if (state is SplashLoading) {
      return _LoadingData(
        text: 'در حال بررسی اطلاعات...',
        progressGradient: GradientTheme.accentGradient,
        textColor: Colors.white.withOpacity(0.8),
      );
    } else if (state is SplashSuccess) {
      return _LoadingData(
        text: 'آماده است!',
        progressGradient: const LinearGradient(
          colors: [Colors.green, Colors.lightGreen],
        ),
        textColor: Colors.white.withOpacity(0.8),
      );
    } else if (state is SplashError) {
      return _LoadingData(
        text: state.message,
        progressGradient: const LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
        textColor: Colors.orange[300]!,
        showError: true,
      );
    }

    return _LoadingData(
      text: 'در حال بارگذاری',
      progressGradient: GradientTheme.accentGradient,
      textColor: Colors.white.withOpacity(0.8),
    );
  }
}

class _LoadingData {
  final String text;
  final Gradient progressGradient;
  final Color textColor;
  final bool showError;
  final bool showRetry;

  _LoadingData({
    required this.text,
    required this.progressGradient,
    required this.textColor,
    this.showError = false,
    this.showRetry = false,
  });
}
