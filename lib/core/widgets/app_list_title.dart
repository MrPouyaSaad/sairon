import 'package:flutter/material.dart';
import 'package:sairon/core/themes/text_styles.dart';

import '../constants/app_constants.dart';

class AppListTitle extends StatelessWidget {
  const AppListTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: Constants.primaryPadding,
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: Text(title, style: AppTextStyles.sectionTitle),
      ),
    );
  }
}
