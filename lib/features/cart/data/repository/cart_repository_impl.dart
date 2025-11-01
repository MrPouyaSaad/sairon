import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/cart/data/source/cart_datasource.dart';
import 'package:sairon/features/cart/domain/entities/cart_item.dart';
import 'package:sairon/features/cart/domain/repository/repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> addItemToCart(String itemId) =>
      safeCall(() => dataSource.addItemToCart(itemId));

  @override
  Future<Either<Failure, void>> clearCart() =>
      safeCall(() => dataSource.clearCart());

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems() =>
      safeCall(() => dataSource.getCartItems());

  @override
  Future<Either<Failure, int>> getCartTotal() =>
      safeCall(() => dataSource.getCartTotal());

  @override
  Future<Either<Failure, void>> removeItemFromCart(String itemId) =>
      safeCall(() => dataSource.removeItemFromCart(itemId));

  @override
  Future<Either<Failure, void>> updateItemQuantity(
    String itemId,
    int quantity,
  ) => safeCall(() => dataSource.updateItemQuantity(itemId, quantity));
}
