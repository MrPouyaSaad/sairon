import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/order/data/models/order_model.dart';

import '../models/cart_validation_model.dart';
import '../models/order_preview_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchOrders({
    String? status,
    int page = 1,
    int limit = 10,
  });

  Future<OrderModel> fetchOrderDetails(String orderId);

  Future<OrderModel> createOrder({
    required String firstName,
    required String lastName,
    required String phone,
    required String province,
    required String city,
    required String address,
    String? postalCode,
  });

  Future<void> cancelOrder(String orderId);

  Future<CartValidationModel> validateCart();

  Future<OrderPreviewModel> calculateOrderPreview({
    required String province,
    required String city,
  });

  Future<String> initPay({
    required String orderId,
    required double amount,
    required String phone,
    required String redirectUrl,
  });

  Future<Map<String, dynamic>> checkPaymentStatus(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio httpClient;

  OrderRemoteDataSourceImpl(this.httpClient);

  @override
  Future<List<OrderModel>> fetchOrders({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    final res = await httpClient.get(
      AppRoutes.orders.base,
      queryParameters: {
        if (status != null) 'status': status,
        'page': page,
        'limit': limit,
      },
    );
    return (res.data['data']['orders'] as List)
        .map((json) => OrderModel.fromJson(json))
        .toList();
  }

  @override
  Future<OrderModel> fetchOrderDetails(String orderId) async {
    final res = await httpClient.get(AppRoutes.orders.details(orderId));
    return OrderModel.fromJson(res.data['data']);
  }

  @override
  Future<OrderModel> createOrder({
    required String firstName,
    required String lastName,
    required String phone,
    required String province,
    required String city,
    required String address,
    String? postalCode,
  }) async {
    final res = await httpClient.post(
      AppRoutes.orders.base,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'province': province,
        'city': city,
        'address': address,
        if (postalCode != null) 'postalCode': postalCode,
      },
    );
    return OrderModel.fromJson(res.data['data']);
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await httpClient.post(AppRoutes.orders.cancel(orderId));
  }

  @override
  Future<CartValidationModel> validateCart() async {
    final res = await httpClient.post('/api/orders/validate-cart');
    return CartValidationModel.fromJson(res.data['data']);
  }

  @override
  Future<OrderPreviewModel> calculateOrderPreview({
    required String province,
    required String city,
  }) async {
    final res = await httpClient.post(
      '/api/orders/preview',
      data: {'province': province, 'city': city},
    );
    return OrderPreviewModel.fromJson(res.data['data']);
  }

  @override
  Future<String> initPay({
    required String orderId,
    required double amount,
    required String phone,
    required String redirectUrl,
  }) async {
    return AppRoutes.payment.redirect(orderId);
  }

  @override
  Future<Map<String, dynamic>> checkPaymentStatus(String orderId) async {
    final res = await httpClient.get(AppRoutes.payment.status(orderId));
    return res.data['data'];
  }
}
