part of 'cart_bloc.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartEntity? cart;

  const CartLoaded({required this.cart});
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}
