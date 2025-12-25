part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

// ================= Orders =================

class FetchOrders extends OrderEvent {
  final String? status;
  final int page;
  final int limit;

  const FetchOrders({this.status, this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [status, page, limit];
}

class FetchOrderDetails extends OrderEvent {
  final String orderId;

  const FetchOrderDetails(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

// ================= Order Actions =================

class CreateOrder extends OrderEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String province;
  final String city;
  final String address;
  final String? postalCode;

  const CreateOrder({
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

class CancelOrder extends OrderEvent {
  final String orderId;

  const CancelOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

// ================= Shipping =================

class CalculateShipping extends OrderEvent {
  final String province;
  final String city;

  const CalculateShipping({required this.province, required this.city});

  @override
  List<Object?> get props => [province, city];
}

// ================= Payment =================

class GetPaymentToken extends OrderEvent {
  final String orderId;
  final double amount;
  final String phone;
  final String redirectUrl;

  const GetPaymentToken({
    required this.orderId,
    required this.amount,
    required this.phone,
    required this.redirectUrl,
  });

  @override
  List<Object?> get props => [orderId, amount, phone, redirectUrl];
}

class CheckPaymentStatus extends OrderEvent {
  final String orderId;

  const CheckPaymentStatus(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
