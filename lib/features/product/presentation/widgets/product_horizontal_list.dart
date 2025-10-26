import 'package:flutter/material.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/presentation/widgets/product_item.dart';
import 'package:sairon/core/widgets/app_list_title.dart';

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({super.key, this.products, required this.title});
  final List<ProductEntity>? products;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppListTitle(title: title),
        SizedBox(
          height: 300,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: Constants.primaryPadding),
            scrollDirection: Axis.horizontal,
            itemCount: products?.length ?? 0,
            itemBuilder: (context, index) {
              return ProductItem(productEntity: products![index]);
            },
          ),
        ),
      ],
    );
  }
}
