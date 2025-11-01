import 'package:sairon/features/cart/domain/entities/total.dart';

class CartEntity {
  final String id;
  final List<CartEntity> items;
  final CartTotalEntity total;
  final int itemCount;

  CartEntity({
    required this.id,
    required this.itemCount,
    required this.items,
    required this.total,
  });
}
