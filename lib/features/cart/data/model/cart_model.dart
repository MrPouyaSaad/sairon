import 'package:sairon/features/cart/domain/entities/cart.dart';
import 'cart_total_model.dart';
import 'cart_item_model.dart';
import 'shipping_info_model.dart';

class CartModel extends CartEntity {
  CartModel.fromJson(Map<String, dynamic> json)
    : super(
        cartId: json['cartId'] ?? json['data']['cartId'],
        totalQuantity:
            json['totalQuantity'] ?? json['data']['totalQuantity'] ?? 0,
        items:
            ((json['items'] ?? json['data']['items']) as List<dynamic>? ?? [])
                .map((e) => CartItemModel.fromJson(e))
                .toList(),
        total: CartTotalModel.fromJson(json['data'] ?? json),
        shippingInfo: ShippingInfoModel.fromJson(
          json['shippingInfo'] ?? json['data']['shippingInfo'] ?? {},
        ),
      );
}
