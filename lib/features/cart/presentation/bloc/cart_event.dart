part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {}

class AddToCart extends CartEvent {
  final String productId;
  final int quantity;
  final String? variantId;

  const AddToCart({required this.productId, this.quantity = 1, this.variantId});

  @override
  List<Object> get props => [productId, quantity];
}

class UpdateQuantityCart extends CartEvent {
  final String productId;
  final int quantity;

  const UpdateQuantityCart({required this.productId, required this.quantity});

  @override
  List<Object> get props => [productId, quantity];
}

class DecrementCart extends CartEvent {
  final String productId;

  const DecrementCart({required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveFromCart extends CartEvent {
  final String productId;

  const RemoveFromCart({required this.productId});

  @override
  List<Object> get props => [productId];
}
