import 'package:flutter/material.dart';
import 'package:sairon/core/widgets/app_list_title.dart';
import 'package:sairon/features/category/domain/entities/category_entity.dart';
import 'package:sairon/features/category/presentation/widgets/category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categoryList});
  final List<CategoryEntity> categoryList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppListTitle(title: 'دسته‌بندی'),
        GridView.builder(
          shrinkWrap: true,

          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.9,
          ),
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return CategoryItem(categoryEntity: categoryList[index]);
          },
        ),
      ],
    );
  }
}
