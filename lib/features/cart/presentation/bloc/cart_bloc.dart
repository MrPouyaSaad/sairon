import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/cart/domain/entities/cart.dart';
import 'package:sairon/features/cart/domain/usecase/cart_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecases cartUsecases;

  CartBloc(this.cartUsecases) : super(CartLoading()) {
    on<CartStarted>((event, emit) async {
      await _loadCart(emit);
    });

    on<AddToCart>((event, emit) async {
      emit(CartLoading());
      final result = await cartUsecases.addItemToCart(
        productId: event.productId,
        quantity: event.quantity,
        variantId: event.variantId,
      );
      final failure = extractLeft(result);
      if (failure != null) {
        emit(CartError(message: failure.message));
        return;
      }
      emit(CartAdded(count: event.quantity));
      await _loadCart(emit);
    });

    on<UpdateQuantityCart>((event, emit) async {
      emit(CartLoading());
      final result = await cartUsecases.updateItemQuantity(
        event.productId,
        event.quantity,
      );
      final failure = extractLeft(result);
      if (failure != null) {
        emit(CartError(message: failure.message));
        return;
      }
      emit(CartAdded(count: event.quantity));
      await _loadCart(emit);
    });
  }

  Future<void> _loadCart(Emitter<CartState> emit) async {
    final cartItems = await cartUsecases.getCartItems();
    final failure = extractLeft(cartItems);
    if (failure != null) {
      emit(CartError(message: failure.message));
      return;
    }
    emit(CartLoaded(cart: extractRight(cartItems)));
  }
}
