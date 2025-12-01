import 'package:dartz/dartz.dart';
import 'package:sairon/features/cart/data/model/shipping_info_model.dart';
import 'package:sairon/features/order/domain/repositories/order_repo.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/order_model.dart';

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

  Future<Either<Failure, ShippingInfoModel>> calculateShipping({
    required String province,
    required String city,
    double subtotal = 0,
    String shippingMethod = 'standard',
  }) {
    return repository.calculateShipping(
      province: province,
      city: city,
      subtotal: subtotal,
      shippingMethod: shippingMethod,
    );
  }

  // Future<Either<Failure, OrderStatsModel>> fetchOrderStats() {
  //   return repository.fetchOrderStats();
  // }

  // Future<Either<Failure, OrderPreviewModel>> validateCart() {
  //   return repository.validateCart();
  // }

  // Future<Either<Failure, OrderPreviewModel>> calculateOrderPreview({
  //   String? province,
  //   String? city,
  // }) {
  //   return repository.calculateOrderPreview(
  //     province: province,
  //     city: city,
  //   );
  // }

  Future<Either<Failure, Map<String, dynamic>>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
  }) {
    return repository.getPaymentToken(
      orderId: orderId,
      amount: amount,
      phone: phone,
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({
    required String orderId,
    required String transactionId,
    required String referenceId,
  }) {
    return repository.verifyPayment(
      orderId: orderId,
      transactionId: transactionId,
      referenceId: referenceId,
    );
  }
}
