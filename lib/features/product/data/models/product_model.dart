import '../../../category/data/models/category_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_images.dart';
import 'attributes_model.dart';
import 'variant_model.dart';

class ProductModel extends ProductEntity {
  ProductModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        orginalPrice: (json['price']?.toString() ?? '0'),
        discount: (json['discount']?.toString() ?? '0'),
        discountType: (json['discount_type'] as String?) ?? 'percent',
        stock: (json['stock']?.toString() ?? '0'),
        discountedPrice: _calculateDiscountedPrice(
          json['price']?.toString() ?? '0',
          json['discount']?.toString() ?? '0',
          (json['discount_type'] as String?) ?? 'percent',
        ),
        images: ProductImages.fromJson(json['images']),
        image: json['image'] ?? '',
        category: json['category'] == null
            ? null
            : CategoryModel.fromJson(json['category']),
        attributes:
            (json['attributes'] as List<dynamic>?)
                ?.map(
                  (e) =>
                      ProductAttributeModel.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            [],
        variants:
            (json['variants'] as List<dynamic>?)
                ?.map(
                  (e) =>
                      ProductVariantModel.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );

  static String _calculateDiscountedPrice(
    String priceStr,
    String discountStr,
    String discountType,
  ) {
    final price = double.tryParse(priceStr) ?? 0;
    final discount = double.tryParse(discountStr) ?? 0;

    double discounted = price;
    if (discount > 0) {
      if (discountType == 'percent') {
        discounted = price - (price * discount / 100);
      } else if (discountType == 'fixed') {
        discounted = price - discount;
      }
    }

    return discounted.toStringAsFixed(0); // تبدیل به String بدون اعشار
  }
}
