import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/cart_validation_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/order_preview_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> fetchOrders({
    String? status,
    int page = 1,
    int limit = 10,
  });

  Future<Either<Failure, OrderModel>> fetchOrderDetails(String orderId);

  Future<Either<Failure, OrderModel>> createOrder({
    required String firstName,
    required String lastName,
    required String phone,
    required String province,
    required String city,
    required String address,
    String? postalCode,
  });

  Future<Either<Failure, void>> cancelOrder(String orderId);

  Future<Either<Failure, CartValidationModel>> validateCart();

  Future<Either<Failure, OrderPreviewModel>> calculateOrderPreview({
    required String province,
    required String city,
  });

  Future<Either<Failure, String>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
    required String redirectUrl,
  });

  Future<Either<Failure, Map<String, dynamic>>> checkPaymentStatus(
    String orderId,
  );
}
