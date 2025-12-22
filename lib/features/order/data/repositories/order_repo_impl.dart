import 'package:dartz/dartz.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/order/data/models/cart_validation_model.dart';
import 'package:sairon/features/order/data/models/order_model.dart';

import '../../domain/repositories/order_repo.dart';
import '../datasources/order_datasource.dart';
import '../models/order_preview_model.dart';

final _dataSource = OrderRemoteDataSourceImpl(ApiConstants.httpClient);
final orderRepository = OrderRepositoryImpl(_dataSource);

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<OrderModel>>> fetchOrders({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    return safeCall(
      () => dataSource.fetchOrders(status: status, page: page, limit: limit),
    );
  }

  @override
  Future<Either<Failure, OrderModel>> fetchOrderDetails(String orderId) async {
    return safeCall(() => dataSource.fetchOrderDetails(orderId));
  }

  @override
  Future<Either<Failure, OrderModel>> createOrder({
    required String firstName,
    required String lastName,
    required String phone,
    required String province,
    required String city,
    required String address,
    String? postalCode,
  }) async {
    return safeCall(
      () => dataSource.createOrder(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        province: province,
        city: city,
        address: address,
        postalCode: postalCode,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    return safeCall(() => dataSource.cancelOrder(orderId));
  }

  @override
  Future<Either<Failure, CartValidationModel>> validateCart() async {
    return safeCall(() => dataSource.validateCart());
  }

  @override
  Future<Either<Failure, OrderPreviewModel>> calculateOrderPreview({
    required String province,
    required String city,
  }) async {
    return safeCall(
      () => dataSource.calculateOrderPreview(province: province, city: city),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
    required String redirectUrl,
  }) async {
    return safeCall(
      () => dataSource.getPaymentToken(
        orderId: orderId,
        amount: amount,
        phone: phone,
        redirectUrl: redirectUrl,
      ),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({
    required String orderId,
    required String transactionId,
    required String referenceId,
  }) async {
    return safeCall(
      () => dataSource.verifyPayment(
        orderId: orderId,
        transactionId: transactionId,
        referenceId: referenceId,
      ),
    );
  }
}
