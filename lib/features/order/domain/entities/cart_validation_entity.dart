import 'package:sairon/features/cart/domain/entities/shipping_info.dart';
import 'order_item_entity.dart';

class CartValidationEntity {
  final bool isValid;
  final String cartId;
  final int itemsCount;
  final List<OrderItemEntity> items;
  final PriceSummaryEntity priceSummary;
  final ShippingInfoEntity shippingInfo;
  final String? errorMessage;

  const CartValidationEntity({
    required this.isValid,
    required this.cartId,
    required this.itemsCount,
    required this.items,
    required this.priceSummary,
    required this.shippingInfo,
    this.errorMessage,
  });
}

class PriceSummaryEntity {
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final int totalQuantity;
  final double totalDiscount;
  final bool isFreeShipping;
  final double? freeShippingThreshold;
  final double? remainingForFreeShipping;

  const PriceSummaryEntity({
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.totalQuantity,
    required this.totalDiscount,
    required this.isFreeShipping,
    this.freeShippingThreshold,
    this.remainingForFreeShipping,
  });
}
