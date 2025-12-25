import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      top: 8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Constants.primaryRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const BackButton(),
      ),
    );
  }
}
