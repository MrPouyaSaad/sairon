import 'package:sairon/features/cart/domain/entities/total.dart';

class CartTotalModel extends CartTotalEntity {
  CartTotalModel.fromJson(Map<String, dynamic> json)
    : super(
        subTotal: json['subtotal'].toDouble(),
        shippingCost: json['shipping'].toDouble(),
        discount: json['discount'].toDouble(),
        total: json['total'].toDouble(),
      );
}
