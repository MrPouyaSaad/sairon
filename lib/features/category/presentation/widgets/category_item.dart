import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/text_styles.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/category/domain/entities/category_entity.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryEntity});
  final CategoryEntity categoryEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.primaryPadding / 3),
      decoration: BoxDecoration(borderRadius: Constants.primaryRadius),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width / 5,
            child: ImageLoadingService(
              imageUrl: categoryEntity.imageUrl,
              borderRadius: Constants.primaryRadius,
            ),
          ),
          Gap(16),
          Text(categoryEntity.name, style: AppTextStyles.sectionTitle),
        ],
      ),
    );
  }
}
