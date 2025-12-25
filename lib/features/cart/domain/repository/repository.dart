import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';

import '../entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addItemToCart({
    required String productId,
    required int quantity,
    String? variantId,
  });

  Future<Either<Failure, void>> removeItemFromCart(String itemId);

  Future<Either<Failure, CartEntity>> getCartItems();

  Future<Either<Failure, void>> clearCart();

  Future<Either<Failure, void>> updateItemQuantity(String itemId, int quantity);

  Future<Either<Failure, int>> getCartTotal();
}
