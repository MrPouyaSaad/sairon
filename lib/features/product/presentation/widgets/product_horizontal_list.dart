import 'package:flutter/material.dart';
import 'package:sairon/features/product/presentation/widgets/product_item.dart';

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ProductItem();
      },
    );
  }
}
