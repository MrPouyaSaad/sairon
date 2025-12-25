import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/cart/domain/entities/cart.dart';

import '../model/cart_model.dart';

abstract class CartDataSource {
  Future<void> addItemToCart({
    required String productId,
    required int quantity,
    String? variantId,
  });

  Future<void> removeItemFromCart(String itemId);
  Future<CartEntity> getCartItems();
  Future<void> clearCart();
  Future<void> updateItemQuantity(String itemId, int quantity);
  Future<int> getCartTotal();
}

class CartDataSourceImpl implements CartDataSource {
  final Dio httpClient;

  CartDataSourceImpl({required this.httpClient});

  @override
  Future<void> addItemToCart({
    required String productId,
    required int quantity,
    String? variantId,
  }) async {
    // ساخت data بر اساس ساختار بک‌اند
    final data = {'productId': productId, 'quantity': quantity};

    // اگر variant داریم، اضافه‌اش کن
    if (variantId != null && variantId.isNotEmpty) {
      data['variantId'] = variantId;
    }

    log('Adding to cart: $data'); // برای دیباگ

    await httpClient.post(AppRoutes.cart.add, data: data);
  }

  @override
  Future<void> clearCart() => httpClient.post(AppRoutes.cart.clear);

  @override
  Future<CartEntity> getCartItems() async {
    final res = await httpClient.get(AppRoutes.cart.getCart);
    log(res.data.toString());

    final data = res.data['data'] as Map<String, dynamic>;
    final cart = CartModel.fromJson(data);

    return cart;
  }

  @override
  Future<int> getCartTotal() {
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
