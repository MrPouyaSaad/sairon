part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class FetchProductsSuccess extends ProductState {
  final List<ProductEntity>? products;

  const FetchProductsSuccess({required this.products});

  @override
  List<Object> get props => [];
}

final class FetchProductsLoading extends ProductState {}

final class FetchProductsError extends ProductState {
  final String message;

  const FetchProductsError({required this.message});
  @override
  List<Object> get props => [message];
}
