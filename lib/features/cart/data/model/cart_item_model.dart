import 'package:sairon/features/cart/domain/entities/cart_item.dart';
import 'package:sairon/features/product/data/models/variant_model.dart';
import '../../../product/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'],
        product: ProductModel.fromJson(json['product']),
        quantity: json['quantity'],
        totalPrice: json['itemTotal'] ?? 0,
        variantId: json['variantId'],
        variant: ProductVariantModel.fromJson(json['variant']),
        lockedPrice: json['lockedPrice'] ?? 0,
        lockedDiscount: json['lockedDiscount'] ?? 0,
        currentPrice: json['currentPrice'] ?? 0,
      );
}
