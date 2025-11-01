import 'package:sairon/features/cart/domain/entities/cart.dart';

import 'cart_total_model.dart';

class CartModel extends CartEntity {
  CartModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['cartId'],
        itemCount: json['totalQuantity'],
        items: (json['items'] as List)
            .map((item) => CartModel.fromJson(item))
            .toList(),
        total: CartTotalModel.fromJson(json['summery']),
      );
}
