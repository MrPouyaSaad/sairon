import 'cart_item.dart';
import 'shipping_info.dart';
import 'total.dart';

class CartEntity {
  final String cartId;
  final int totalQuantity;
  final List<CartItemEntity> items;
  final CartTotalEntity total;
  final ShippingInfoEntity shippingInfo;

  CartEntity({
    required this.cartId,
    required this.items,
    required this.total,
    required this.totalQuantity,
    required this.shippingInfo,
  });
}
