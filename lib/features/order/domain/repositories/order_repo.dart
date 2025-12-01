import 'package:dartz/dartz.dart';
import 'package:sairon/features/cart/data/model/shipping_info_model.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/order_model.dart';

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

  Future<Either<Failure, ShippingInfoModel>> calculateShipping({
    required String province,
    required String city,
    double subtotal = 0,
    String shippingMethod = 'standard',
  });

  // Future<Either<Failure, OrderStatsModel>> fetchOrderStats();

  // Future<Either<Failure, OrderPreviewModel>> validateCart();

  // Future<Either<Failure, OrderPreviewModel>> calculateOrderPreview({
  //   String? province,
  //   String? city,
  // });

  Future<Either<Failure, Map<String, dynamic>>> getPaymentToken({
    required String orderId,
    required double amount,
    required String phone,
  });

  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({
    required String orderId,
    required String transactionId,
    required String referenceId,
  });
}
