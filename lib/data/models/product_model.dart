import '../../domain/value_objects/product_images.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String orginalPrice;
  final String discountedPrice;
  final String discount;
  final String discountType;
  final String stock;
  final ProductImages images;

  ProductModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      description = json['description'],
      orginalPrice = json['orginal_price'],
      discountedPrice = json['discounted_price'],
      discount = json['discount'],
      discountType = json['discount_type'],
      stock = json['stock'],
      images = ProductImages.fromJson(json['images']);
}
