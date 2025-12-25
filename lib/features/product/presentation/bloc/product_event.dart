part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendedProducts extends ProductEvent {
  final int productId;
  final int page;

  const FetchRecommendedProducts({required this.productId, this.page = 1});

  @override
  List<Object> get props => [productId, page];
}

class FetchProductsByCategory extends ProductEvent {
  final int categoryId;
  final int page;

  const FetchProductsByCategory({required this.categoryId, this.page = 1});
  @override
  List<Object> get props => [categoryId, page];
}
