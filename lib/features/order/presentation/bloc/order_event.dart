part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch Orders
class FetchOrders extends OrderEvent {
  final String? status;
  final int page;
  final int limit;

  FetchOrders({this.status, this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [status, page, limit];
}

// Fetch Order Details
class FetchOrderDetails extends OrderEvent {
  final String orderId;
  FetchOrderDetails(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

// Create Order
class CreateOrder extends OrderEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String province;
  final String city;
  final String address;
  final String? postalCode;

  CreateOrder({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.province,
    required this.city,
    required this.address,
    this.postalCode,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phone,
    province,
    city,
    address,
    postalCode,
  ];
}

// Cancel Order
class CancelOrder extends OrderEvent {
  final String orderId;
  CancelOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

// Calculate shipping
class CalculateShipping extends OrderEvent {
  final String province;
  final String city;
  final double subtotal;
  final String shippingMethod;

  CalculateShipping({
    required this.province,
    required this.city,
    this.subtotal = 0,
    this.shippingMethod = 'standard',
  });

  @override
  List<Object?> get props => [province, city, subtotal, shippingMethod];
}

// Payment token
class GetPaymentToken extends OrderEvent {
  final String orderId;
  final double amount;
  final String phone;

  GetPaymentToken({
    required this.orderId,
    required this.amount,
    required this.phone,
  });

  @override
  List<Object?> get props => [orderId, amount, phone];
}

// Verify Payment
class VerifyPayment extends OrderEvent {
  final String orderId;
  final String transactionId;
  final String referenceId;

  VerifyPayment({
    required this.orderId,
    required this.transactionId,
    required this.referenceId,
  });

  @override
  List<Object?> get props => [orderId, transactionId, referenceId];
}
