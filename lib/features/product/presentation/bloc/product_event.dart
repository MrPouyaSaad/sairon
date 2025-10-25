part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final int page;

  const FetchProducts({this.page = 1});

  @override
  List<Object> get props => [page];
}

class FetchProductsByCategory extends ProductEvent {
  final int categoryId;
  final int page;

  const FetchProductsByCategory({required this.categoryId, this.page = 1});

  @override
  List<Object> get props => [categoryId, page];
}

class FetchProductsByLabel extends ProductEvent {
  final String label;
  final int page;

  const FetchProductsByLabel({required this.label, this.page = 1});

  @override
  List<Object> get props => [label, page];
}

class FetchProductsBySearch extends ProductEvent {
  final String keyword;
  final int page;

  const FetchProductsBySearch({required this.keyword, this.page = 1});

  @override
  List<Object> get props => [keyword, page];
}

class FetchRecommendedProducts extends ProductEvent {
  final int productId;
  final int page;

  const FetchRecommendedProducts({required this.productId, this.page = 1});

  @override
  List<Object> get props => [productId, page];
}

class FetchProductById extends ProductEvent {
  final int productId;

  const FetchProductById({required this.productId});

  @override
  List<Object> get props => [productId];
}
