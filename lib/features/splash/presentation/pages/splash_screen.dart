import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/features/root/presentation/pages/root.dart';
import 'package:sairon/features/splash/presentation/bloc/splash_bloc.dart';

import '../widgets/splash_background.dart';
import '../widgets/splash_content.dart';
import '../widgets/splash_loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _eventSent = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_eventSent) {
        _eventSent = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<SplashBloc>().add(CheckInitialData());
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        _handleSplashState(state);
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF7E22CE)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              const SplashBackground(),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: BlocBuilder<SplashBloc, SplashState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SplashContent(
                            controller: _controller,
                            scaleAnimation: _scaleAnimation,
                            fadeAnimation: _fadeAnimation,
                          ),

                          const SizedBox(height: 60),

                          if (state is SplashLoading)
                            SplashLoadingIndicator(controller: _controller)
                          else if (state is SplashError)
                            AppErrorWidget(
                              textColor: AppColors.surfaceColor,
                              buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.backgroundColor,
                                foregroundColor: AppColors.textPrimary,
                              ),
                              buttonTextColor: AppColors.textPrimary,
                              message: state.message,
                              onRetry: () {
                                context.read<SplashBloc>().add(
                                  CheckInitialData(),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              const _BottomOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSplashState(SplashState state) {
    if (state is SplashSuccess) {
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.off(() => RootScreen());
      });
    }
  }
}

class _BottomOverlay extends StatelessWidget {
  const _BottomOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF0F172A).withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: Center(
          child: Text(
            'نسخه ۱.۰.۰',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
