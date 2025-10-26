import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/domain/repositories/category_repository.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../../product/domain/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;

  HomeBloc({required this.productRepository, required this.categoryRepository})
    : super(HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        productRepository.fetchProductsByLabel('discounted', event.page),
        productRepository.fetchProductsByLabel('recommended', event.page),
        productRepository.fetchProductsByLabel('bestseller', event.page),
        categoryRepository.fetchCategories(),
      ]);

      final hasError = results.any((r) => r is Left);
      if (hasError) {
        final failure = results.whereType<Left<Failure, dynamic>>().first.value;
        emit(HomeError(failure.message));
        return;
      }

      final discounted =
          (results[0] as Right<Failure, List<ProductEntity>>).value;
      final recommended =
          (results[1] as Right<Failure, List<ProductEntity>>).value;
      final bestSellers =
          (results[2] as Right<Failure, List<ProductEntity>>).value;
      final categories =
          (results[3] as Right<Failure, List<CategoryEntity>>).value;

      emit(
        HomeLoaded(
          topProducts: discounted,
          newArrivals: recommended,
          bestSellers: bestSellers,
          categories: categories,
          // banners: []
        ),
      );
    } catch (e) {
      emit(HomeError('خطای غیرمنتظره در دریافت اطلاعات.'));
    }
  }
}
