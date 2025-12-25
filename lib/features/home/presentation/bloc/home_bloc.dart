import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sairon/features/category/domain/usecases/category_usecases.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';
import 'package:sairon/features/slider/domain/entities/slider_entity.dart';
import 'package:sairon/features/slider/domain/usecases/slider_usecases.dart';
import '../../../../core/errors/exception_helper.dart';
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

    final discountedResult = await productUseCases.fetchProductsByLabel(
      'discounted',
      event.page,
    );
    final recommendedResult = await productUseCases.fetchProductsByLabel(
      'recommended',
      event.page,
    );
    final bestSellerResult = await productUseCases.fetchProductsByLabel(
      'bestseller',
      event.page,
    );
    final categoryResult = await categoryUseCases.fetchCategories();
    final sliderResult = await sliderUseCase.fetchSliders();

    final failure =
        extractLeft(discountedResult) ??
        extractLeft(recommendedResult) ??
        extractLeft(bestSellerResult) ??
        extractLeft(categoryResult) ??
        extractLeft(sliderResult);

    if (failure != null) {
      emit(HomeError(failure.message));
      return;
    }

    emit(
      HomeLoaded(
        topProducts: extractRight(discountedResult)!,
        recommendedProducts: extractRight(recommendedResult)!,
        bestSellers: extractRight(bestSellerResult)!,
        categories: extractRight(categoryResult)!,
        banners: extractRight(sliderResult)!,
      ),
    );
  }
}
