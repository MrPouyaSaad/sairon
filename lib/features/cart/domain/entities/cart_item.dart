import 'package:sairon/features/product/domain/entities/product_entity.dart';

class CartItemEntity {
  final String id;
  final ProductEntity productEntity;
  final int quantity;
  final double totalPrice;

  CartItemEntity({
    required this.id,
    required this.productEntity,
    required this.quantity,
    required this.totalPrice,
  });
}
