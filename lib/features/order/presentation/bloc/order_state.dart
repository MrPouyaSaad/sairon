part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

// ================= Base =================

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

// ================= Error =================

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

// ================= Orders =================

class OrdersLoaded extends OrderState {
  final List<OrderModel>? orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderDetailsLoaded extends OrderState {
  final OrderModel? order;

  const OrderDetailsLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

// ================= Order Actions =================

class OrderCreated extends OrderState {
  final OrderModel? order;

  const OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCancelled extends OrderState {}

// ================= Shipping =================

class ShippingCalculated extends OrderState {
  final OrderPreviewModel? shipping;

  const ShippingCalculated(this.shipping);

  @override
  List<Object?> get props => [shipping];
}

// ================= Payment =================

/// در حال گرفتن توکن درگاه
class PaymentTokenLoading extends OrderState {}

/// توکن درگاه آماده است
class PaymentTokenLoaded extends OrderState {
  final String? data;

  const PaymentTokenLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

/// در حال بررسی وضعیت پرداخت (بعد از Deeplink)
class PaymentChecking extends OrderState {}

/// پرداخت با موفقیت تایید شده (از بک‌اند)
class PaymentSuccess extends OrderState {
  final dynamic data;

  const PaymentSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

/// پرداخت ناموفق یا وضعیت غیر success
class PaymentFailed extends OrderState {
  final String? status;

  const PaymentFailed(this.status);

  @override
  List<Object?> get props => [status];
}
