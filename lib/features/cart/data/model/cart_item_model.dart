import 'package:sairon/features/cart/domain/entities/cart_item.dart';

import '../../../product/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'],
        productEntity: ProductModel.fromJson(json['product']),
        quantity: json['quantity'],
        totalPrice: json['total_price'].toDouble(),
      );
}
