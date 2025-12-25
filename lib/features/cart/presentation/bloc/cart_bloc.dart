import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/cart/data/repository/cart_repository_impl.dart';
import 'package:sairon/features/cart/domain/entities/cart.dart';
import 'package:sairon/features/cart/domain/usecase/cart_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecases usecases;

  CartBloc(this.usecases) : super(CartInitial()) {
    on<CartStarted>(_onStarted);
    on<CartAdd>(_onAdd);
    on<CartRemove>(_onRemove);
    on<CartIncrease>(_onIncrease);
    on<CartDecrease>(_onDecrease);
    on<CartClear>(_onClear);
  }

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    await _loadCart(emit);
  }

  Future<void> _onAdd(CartAdd event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final r = await usecases.addItemToCart(
      productId: event.productId,
      quantity: event.quantity,
      variantId: event.variantId,
    );

    final f = extractLeft(r);
    if (f != null) return emit(CartError(f.message));

    await _loadCart(emit);
  }

  Future<void> _onIncrease(CartIncrease event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final r = await usecases.updateItemQuantity(event.itemId, event.quantity);

    final f = extractLeft(r);
    if (f != null) return emit(CartError(f.message));

    await _loadCart(emit);
  }

  Future<void> _onDecrease(CartDecrease event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final r = await usecases.updateItemQuantity(event.itemId, event.quantity);

    final f = extractLeft(r);
    if (f != null) return emit(CartError(f.message));

    await _loadCart(emit);
  }

  Future<void> _onRemove(CartRemove event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final r = await usecases.removeItemFromCart(event.itemId);

    final f = extractLeft(r);
    if (f != null) return emit(CartError(f.message));

    await _loadCart(emit);
  }

  Future<void> _onClear(CartClear event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final r = await usecases.clearCart();

    final f = extractLeft(r);
    if (f != null) return emit(CartError(f.message));

    await _loadCart(emit);
  }

  Future<void> _loadCart(Emitter<CartState> emit) async {
    final cart = await usecases.getCartItems();
    final failure = extractLeft(cart);

    if (failure != null) return emit(CartError(failure.message));

    final data = extractRight(cart);

    cartRepository.cartNotifier.value = data;

    emit(CartLoaded(cart: data));
  }
}
