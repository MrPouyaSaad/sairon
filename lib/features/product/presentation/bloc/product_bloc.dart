import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCases useCases;
  ProductBloc(this.useCases) : super(FetchProductsLoading()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchRecommendedProducts) {
        emit(FetchProductsLoading());
        final products = await useCases.fetchRecommendedProducts(
          event.productId,
          event.page,
        );
        final failure = extractLeft(products);
        if (failure != null) {
          emit(FetchProductsError(message: failure.message));
          return;
        }
        emit(FetchProductsSuccess(products: extractRight(products)));
      } else if (event is FetchProductsByCategory) {
        emit(FetchProductsLoading());
        final products = await useCases.fetchProductsByCategory(
          event.categoryId,
          event.page,
        );
        final failure = extractLeft(products);
        if (failure != null) {
          emit(FetchProductsError(message: failure.message));
          return;
        }
        emit(FetchProductsSuccess(products: extractRight(products)));
      }
    });
  }
}
