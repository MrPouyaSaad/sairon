import 'package:dartz/dartz.dart';
import 'package:sairon/features/order/domain/repositories/order_repo.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/cart_validation_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/order_preview_model.dart';

class OrderUseCases {
  final OrderRepository repository;

  OrderUseCases({required this.repository});

  Future<Either<Failure, List<OrderModel>>> fetchOrders({
    String? status,
    int page = 1,
    int limit = 10,
  }) {
    return repository.fetchOrders(status: status, page: page, limit: limit);
  }

  Future<Either<Failure, OrderModel>> fetchOrderDetails(String orderId) {
    return repository.fetchOrderDetails(orderId);
  }

  Future<Either<Failure, OrderModel>> createOrder({
    required String firstName,
    required String lastName,
    required String phone,
    required String province,
    required String city,
    required String address,
    String? postalCode,
  }) {
    return repository.createOrder(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      province: province,
      city: city,
      address: address,
      postalCode: postalCode,
    );
  }

  Future<Either<Failure, void>> cancelOrder(String orderId) {
    return repository.cancelOrder(orderId);
  }

  Future<Either<Failure, CartValidationModel>> validateCart() {
    return repository.validateCart();
  }

  Future<Either<Failure, OrderPreviewModel>> calculateOrderPreview({
    required String province,
    required String city,
  }) {
    return repository.calculateOrderPreview(province: province, city: city);
  }

  Future<Either<Failure, String>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
    required String redirectUrl,
  }) {
    return repository.getPaymentToken(
      orderId: orderId,
      amount: amount,
      phone: phone,
      redirectUrl: redirectUrl,
    );
  }

  /// 🔥 تنها usecase پرداخت بعد از deeplink
  Future<Either<Failure, Map<String, dynamic>>> checkPaymentStatus(
    String orderId,
  ) {
    return repository.checkPaymentStatus(orderId);
  }
}
