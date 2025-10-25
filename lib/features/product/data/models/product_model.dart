import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_images.dart';

class ProductModel extends ProductEntity {
  ProductModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        orginalPrice: json['orginal_price'],
        discountedPrice: json['discounted_price'],
        discount: json['discount'],
        discountType: json['discount_type'],
        stock: json['stock'],
        images: ProductImages.fromJson(json['images']),
      );
}
