import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:sairon/features/category/domain/usecases/category_usecases.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';
import 'package:sairon/features/slider/domain/entities/slider_entity.dart';
import 'package:sairon/features/slider/domain/usecases/slider_usecases.dart';
import '../../../../core/errors/failures.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../product/domain/entities/product_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductUseCases productUseCases;
  final SliderUsecases sliderUseCase;
  final CategoryUseCases categoryUseCases;
  HomeBloc({
    required this.productUseCases,
    required this.categoryUseCases,
    required this.sliderUseCase,
  }) : super(HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        productUseCases.fetchProductsByLabel('discounted', event.page),
        productUseCases.fetchProductsByLabel('recommended', event.page),
        productUseCases.fetchProductsByLabel('bestseller', event.page),
        categoryUseCases.fetchCategories(),
        sliderUseCase.fetchSliders(),
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
      final banners = (results[4] as Right<Failure, List<SliderEntity>>).value;

      emit(
        HomeLoaded(
          topProducts: discounted,
          newArrivals: recommended,
          bestSellers: bestSellers,
          categories: categories,
          banners: banners,
        ),
      );
    } catch (e) {
      emit(HomeError('خطای غیرمنتظره در دریافت اطلاعات.'));
    }
  }
}
