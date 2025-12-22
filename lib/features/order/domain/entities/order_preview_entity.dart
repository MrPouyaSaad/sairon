import 'package:sairon/features/cart/domain/entities/shipping_info.dart';

class OrderPreviewEntity {
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final int totalQuantity;
  final double totalDiscount;
  final bool isFreeShipping;
  final double? freeShippingThreshold;
  final double? remainingForFreeShipping;
  final int itemsCount;
  final String cartId;
  final ShippingInfoEntity shippingInfo;
  final TaxInfoEntity taxInfo;
  final bool isValid;

  const OrderPreviewEntity({
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.totalQuantity,
    required this.totalDiscount,
    required this.isFreeShipping,
    this.freeShippingThreshold,
    this.remainingForFreeShipping,
    required this.itemsCount,
    required this.cartId,
    required this.shippingInfo,
    required this.taxInfo,
    required this.isValid,
  });
}

class TaxInfoEntity {
  final String rate;
  final double amount;

  const TaxInfoEntity({required this.rate, required this.amount});
}
