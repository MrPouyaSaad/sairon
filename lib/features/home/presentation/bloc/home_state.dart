part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductEntity> topProducts;
  final List<ProductEntity> newArrivals;
  final List<ProductEntity> bestSellers;
  final List<CategoryEntity> categories;
  // final List<BannerEntity> banners;

  const HomeLoaded({
    this.topProducts = const [],
    this.newArrivals = const [],
    this.bestSellers = const [],
    this.categories = const [],
    // this.banners = const [],
  });

  @override
  List<Object?> get props => [
    topProducts,
    newArrivals,
    bestSellers,
    // categories,
    // banners,
  ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
