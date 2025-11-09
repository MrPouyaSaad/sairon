import 'package:sairon/features/cart/domain/entities/total.dart';

class CartTotalModel extends CartTotalEntity {
  CartTotalModel.fromJson(Map<String, dynamic> json)
    : super(
        subTotal: json['subtotal'] ?? json['data']['subtotal'] ?? 0,
        shipping: json['shipping'] ?? json['data']['shipping'] ?? 0,
        tax: json['tax'] ?? json['data']['tax'] ?? 0,
        total: json['total'] ?? json['data']['total'] ?? 0,
      );
}
