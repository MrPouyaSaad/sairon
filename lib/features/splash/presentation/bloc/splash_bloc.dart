// features/splash/presentation/bloc/splash_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/cart/domain/usecase/cart_usecases.dart';
import 'package:sairon/features/auth/data/repositories/token_repo.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CartUsecases cartUsecase;

  SplashBloc({required this.cartUsecase}) : super(SplashInitial()) {
    on<CheckInitialData>(_onCheckInitialData);
  }

  Future<void> _onCheckInitialData(
    CheckInitialData event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    try {
      final isLoggedIn = TokenRepository.isLoggedIn;
      int cartItemsCount = 0;

      if (isLoggedIn) {
        final cartResult = await cartUsecase.getCartItems();
        final failure = extractLeft(cartResult);

        if (failure != null) {
          if (requiresLogout(failure)) {
            emit(SplashSuccess(cartItemsCount: 0, isUserLoggedIn: false));
            return;
          }
          emit(SplashError(message: failure.message));
          return;
        }

        final cart = extractRight(cartResult);
        cartItemsCount = cart?.totalQuantity ?? 0;
      }

      emit(
        SplashSuccess(
          cartItemsCount: cartItemsCount,
          isUserLoggedIn: isLoggedIn,
        ),
      );
    } catch (error) {
      emit(SplashError(message: 'خطا در بارگذاری اطلاعات اولیه'));
    }
  }
}
