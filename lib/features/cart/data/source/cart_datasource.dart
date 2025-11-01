import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/cart/data/model/cart_item_model.dart';

import '../../domain/entities/cart_item.dart';

abstract class CartDataSource {
  Future<void> addItemToCart(String itemId);
  Future<void> removeItemFromCart(String itemId);
  Future<List<CartItemEntity>> getCartItems();
  Future<void> clearCart();
  Future<void> updateItemQuantity(String itemId, int quantity);
  Future<int> getCartTotal();
}

class CartDataSourceImpl implements CartDataSource {
  final Dio httpClient;

  CartDataSourceImpl({required this.httpClient});
  @override
  Future<void> addItemToCart(String itemId) =>
      httpClient.post(AppRoutes.cart.add, data: {'id': itemId});

  @override
  Future<void> clearCart() => httpClient.post(AppRoutes.cart.clear);

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final res = await httpClient.get(AppRoutes.cart.getCart);
    final List<CartItemEntity> items = [];
    for (var item in res.data['items']) {
      items.add(CartItemModel.fromJson(item));
    }
    return items;
  }

  @override
  Future<int> getCartTotal() {
    // TODO: implement getCartTotal
    throw UnimplementedError();
  }

  @override
  Future<void> removeItemFromCart(String itemId) async {
    await httpClient.delete(AppRoutes.cart.remove(itemId));
  }

  @override
  Future<void> updateItemQuantity(String itemId, int quantity) async {
    await httpClient.put(
      AppRoutes.cart.update,
      data: {"productId": itemId, "quantity": quantity},
    );
  }
}
