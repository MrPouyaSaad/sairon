import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';

part 'product_event.dart';
part 'product_state.dart';

class RecommendedProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCases useCases;
  RecommendedProductBloc(this.useCases)
    : super(FetchRecommendedProductsLoading()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchRecommendedProducts) {
        emit(FetchRecommendedProductsLoading());
        final products = await useCases.fetchRecommendedProducts(
          event.productId,
          event.page,
        );
        final failure = extractLeft(products);
        if (failure != null) {
          emit(FetchRecommendedProductsError(message: failure.message));
          return;
        }
        emit(FetchRecommendedProductsSuccess(products: extractRight(products)));
      }
    });
  }
}
