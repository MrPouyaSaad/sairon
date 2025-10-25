import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../../product/domain/repositories/product_repository.dart';
import '../../../../core/errors/failures.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;

  HomeBloc({required this.productRepository}) : super(HomeLoading()) {
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
      ]);

      bool hasError = results.any((r) => r.isLeft());
      if (hasError) {
        final failure = results
            .firstWhere((r) => r.isLeft())
            .fold((f) => f, (_) => null);
        emit(HomeError(failure!.message));
        return;
      }

      final discounted = results[0].getOrElse(() => []);
      final recommended = results[1].getOrElse(() => []);
      final bestSellers = results[2].getOrElse(() => []);

      emit(
        HomeLoaded(
          topProducts: discounted,
          newArrivals: recommended,
          bestSellers: bestSellers,
          // categories: [],
          // banners: [],
        ),
      );
    } catch (e) {
      emit(HomeError('خطای غیرمنتظره در دریافت محصولات.'));
    }
  }
}
