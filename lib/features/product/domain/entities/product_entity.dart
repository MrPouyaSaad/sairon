import 'package:sairon/features/category/domain/entities/category_entity.dart';
import 'package:sairon/features/product/domain/entities/attributes.dart';
import 'package:sairon/features/product/domain/entities/variants.dart';

import 'product_images.dart';

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final String orginalPrice;
  final String discountedPrice;
  final String discount;
  final String discountType;
  final String stock;
  final String image;
  final ProductImages images;
  final CategoryEntity category;
  final List<ProductAttributeEntity> attributes;
  final List<ProductVariantEntity> variants;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.orginalPrice,
    required this.discountedPrice,
    required this.discount,
    required this.discountType,
    required this.stock,
    required this.images,
    required this.image,
    required this.category,
    required this.attributes,
    required this.variants,
  });
}
