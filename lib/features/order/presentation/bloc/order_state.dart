part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

// Success states
class OrdersLoaded extends OrderState {
  final List<OrderModel>? orders;
  OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderDetailsLoaded extends OrderState {
  final OrderModel? order;
  OrderDetailsLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCreated extends OrderState {
  final OrderModel? order;
  OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCancelled extends OrderState {}

class ShippingCalculated extends OrderState {
  final OrderPreviewModel? shipping;
  ShippingCalculated(this.shipping);

  @override
  List<Object?> get props => [shipping];
}

class PaymentTokenLoaded extends OrderState {
  final Map<String, dynamic>? data;
  PaymentTokenLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class PaymentVerified extends OrderState {
  final Map<String, dynamic>? data;
  PaymentVerified(this.data);

  @override
  List<Object?> get props => [data];
}
