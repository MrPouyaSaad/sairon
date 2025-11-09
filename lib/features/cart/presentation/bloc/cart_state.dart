part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartEntity? cart;

  const CartLoaded({required this.cart});

  @override
  List<Object> get props => [];
}

class CartAdded extends CartState {
  final int count;

  const CartAdded({required this.count});

  @override
  List<Object> get props => [count];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}
