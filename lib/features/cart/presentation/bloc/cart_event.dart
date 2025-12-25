part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartStarted extends CartEvent {}

class CartAdd extends CartEvent {
  final String productId;
  final int quantity;
  final String? variantId;

  const CartAdd({
    required this.productId,
    required this.quantity,
    this.variantId,
  });
}

class CartRemove extends CartEvent {
  final String itemId;

  const CartRemove(this.itemId);
}

class CartIncrease extends CartEvent {
  final String itemId;
  final int quantity;

  const CartIncrease({required this.itemId, required this.quantity});
}

class CartDecrease extends CartEvent {
  final String itemId;
  final int quantity;

  const CartDecrease({required this.itemId, required this.quantity});
}

class CartClear extends CartEvent {}
