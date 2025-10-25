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
  final ProductImages images;

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
  });
}
