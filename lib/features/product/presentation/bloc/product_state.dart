part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class FetchRecommendedProductsSuccess extends ProductState {
  final List<ProductEntity>? products;

  const FetchRecommendedProductsSuccess({required this.products});

  @override
  List<Object> get props => [];
}

final class FetchRecommendedProductsLoading extends ProductState {}

final class FetchRecommendedProductsError extends ProductState {
  final String message;

  const FetchRecommendedProductsError({required this.message});
  @override
  List<Object> get props => [message];
}
