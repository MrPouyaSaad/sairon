import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sairon/core/themes/app_colors.dart';

class ScreenLoadingIndicator extends StatelessWidget {
  const ScreenLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 25,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
