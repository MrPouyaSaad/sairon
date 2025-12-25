import 'package:sairon/features/product/domain/entities/product_entity.dart';

class OrderItemEntity {
  final String id;
  final String productId;
  final String? variantId;
  final int quantity;
  final double unitPrice;
  final double originalPrice;
  final double discount;
  final String discountType; // 'amount' or 'percentage'
  final double total;
  final ProductEntity product;
  final Map<String, dynamic>? variantAttributes;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    this.variantId,
    required this.quantity,
    required this.unitPrice,
    required this.originalPrice,
    required this.discount,
    required this.discountType,
    required this.total,
    required this.product,
    this.variantAttributes,
  });
}
