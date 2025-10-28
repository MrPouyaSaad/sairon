import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/cart/domain/repository/repository.dart';

class CartUsecases {
  final CartRepository repository;

  CartUsecases({required this.repository});

  Future<Either<Failure, void>> addItemToCart(String itemId) async =>
      await repository.addItemToCart(itemId);

  Future<Either<Failure, void>> removeItemFromCart(String itemId) async =>
      await repository.removeItemFromCart(itemId);

  Future<Either<Failure, List>> getCartItems() async =>
      await repository.getCartItems();

  Future<Either<Failure, void>> clearCart() async =>
      await repository.clearCart();

  Future<Either<Failure, void>> updateItemQuantity(
    String itemId,
    int quantity,
  ) async => repository.updateItemQuantity(itemId, quantity);

  Future<Either<Failure, int>> getCartTotal() async =>
      await repository.getCartTotal();
}
