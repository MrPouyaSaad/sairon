import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_images.dart';

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
