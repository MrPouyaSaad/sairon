import 'package:sairon/features/product/domain/entities/variants.dart';

import '../../../product/domain/entities/product_entity.dart';

class CartItemEntity {
  final String id;
  final ProductEntity product;
  final int quantity;
  final int totalPrice;
  final String? variantId;
  final ProductVariantEntity? variant;
  final int lockedPrice;
  final int lockedDiscount;
  final int currentPrice;

  CartItemEntity({
    required this.id,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.variantId,
    required this.variant,
    required this.lockedPrice,
    required this.lockedDiscount,
    required this.currentPrice,
  });
}
