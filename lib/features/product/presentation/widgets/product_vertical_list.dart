import 'package:flutter/material.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/presentation/widgets/empty_productslist.dart';
import 'package:sairon/features/product/presentation/widgets/horizontal_product_card.dart';

class ProductVerticalList extends StatelessWidget {
  const ProductVerticalList({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products.isEmpty
          ? EmptyProductsList()
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return HorizontalProductCard(productEntity: products[index]);
              },
            ),
    );
  }
}
