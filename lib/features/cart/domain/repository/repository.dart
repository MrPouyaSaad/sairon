import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addItemToCart(String itemId);
  Future<Either<Failure, void>> removeItemFromCart(String itemId);
  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>> clearCart();
  Future<Either<Failure, void>> updateItemQuantity(String itemId, int quantity);
  Future<Either<Failure, int>> getCartTotal();
}
