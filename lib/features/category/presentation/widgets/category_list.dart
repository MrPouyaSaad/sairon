// lib/features/category/presentation/widgets/category_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sairon/core/widgets/app_list_title.dart';
import 'package:sairon/features/category/domain/entities/category_entity.dart';
import 'package:sairon/features/category/presentation/widgets/category_item.dart';

import '../../../product/presentation/pages/products_list_page.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categoryList});
  final List<CategoryEntity> categoryList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppListTitle(title: 'دسته‌بندی‌ها'),

        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              categoryEntity: categoryList[index],
              onTap: () => Get.to(ProductScreen(category: categoryList[index])),
            );
          },
        ),
      ],
    ).marginSymmetric(vertical: 8);
  }
}
