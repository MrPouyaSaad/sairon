import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/cart/data/model/shipping_info_model.dart';
import 'package:sairon/features/order/data/models/order_model.dart';

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
  Future<ShippingInfoModel> calculateShipping({
    required String province,
    required String city,
    double subtotal = 0,
    String shippingMethod = 'standard',
  });

  Future<Map<String, dynamic>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
  });
  Future<Map<String, dynamic>> verifyPayment({
    required String orderId,
    required String transactionId,
    required String referenceId,
  });
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
  Future<ShippingInfoModel> calculateShipping({
    required String province,
    required String city,
    double subtotal = 0,
    String shippingMethod = 'standard',
  }) async {
    final res = await httpClient.post(
      '/api/orders/shipping/calculate',
      data: {
        'province': province,
        'city': city,
        'subtotal': subtotal,
        'shippingMethod': shippingMethod,
      },
    );
    return ShippingInfoModel.fromJson(res.data['data']);
  }

  @override
  Future<Map<String, dynamic>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
  }) async {
    final res = await httpClient.post(
      AppRoutes.payment.create,
      data: {'orderId': orderId, 'amount': amount, 'phone': phone},
    );
    return res.data['data'];
  }

  @override
  Future<Map<String, dynamic>> verifyPayment({
    required String orderId,
    required String transactionId,
    required String referenceId,
  }) async {
    final res = await httpClient.post(
      AppRoutes.payment.samanVerify,
      data: {
        'orderId': orderId,
        'transactionId': transactionId,
        'referenceId': referenceId,
      },
    );
    return res.data['data'];
  }
}
