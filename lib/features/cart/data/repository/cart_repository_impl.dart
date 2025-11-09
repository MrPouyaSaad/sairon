import 'package:dartz/dartz.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/cart/data/source/cart_datasource.dart';
import 'package:sairon/features/cart/domain/entities/cart.dart';
import 'package:sairon/features/cart/domain/repository/repository.dart';

final _dataSource = CartDataSourceImpl(httpClient: ApiConstants.httpClient);
final cartRepository = CartRepositoryImpl(dataSource: _dataSource);

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> addItemToCart({
    required String productId,
    required int quantity,
    String? variantId,
  }) => safeCall(
    () => dataSource.addItemToCart(
      productId: productId,
      quantity: quantity,
      variantId: variantId,
    ),
  );

  @override
  Future<Either<Failure, void>> clearCart() =>
      safeCall(() => dataSource.clearCart());

  @override
  Future<Either<Failure, CartEntity>> getCartItems() =>
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
