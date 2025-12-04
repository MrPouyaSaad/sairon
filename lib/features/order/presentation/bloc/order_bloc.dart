import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/order/domain/usecases/order_usecases.dart';
import 'package:sairon/features/order/data/models/order_model.dart';
import 'package:sairon/features/cart/data/model/shipping_info_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCases useCases;

  OrderBloc(this.useCases) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      emit(OrderLoading());

      if (event is FetchOrders) {
        final result = await useCases.fetchOrders(
          status: event.status,
          page: event.page,
          limit: event.limit,
        );

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(OrdersLoaded(extractRight(result)));
      } else if (event is FetchOrderDetails) {
        final result = await useCases.fetchOrderDetails(event.orderId);

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(OrderDetailsLoaded(extractRight(result)));
      } else if (event is CreateOrder) {
        final result = await useCases.createOrder(
          firstName: event.firstName,
          lastName: event.lastName,
          phone: event.phone,
          province: event.province,
          city: event.city,
          address: event.address,
          postalCode: event.postalCode,
        );

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(OrderCreated(extractRight(result)));
      } else if (event is CancelOrder) {
        final result = await useCases.cancelOrder(event.orderId);

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(OrderCancelled());
      } else if (event is CalculateShipping) {
        final result = await useCases.calculateShipping(
          province: event.province,
          city: event.city,
          subtotal: event.subtotal,
          shippingMethod: event.shippingMethod,
        );

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(ShippingCalculated(extractRight(result)));
      } else if (event is GetPaymentToken) {
        final result = await useCases.getPaymentToken(
          orderId: event.orderId,
          amount: event.amount,
          phone: event.phone,
        );

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(PaymentTokenLoaded(extractRight(result)));
      } else if (event is VerifyPayment) {
        final result = await useCases.verifyPayment(
          orderId: event.orderId,
          transactionId: event.transactionId,
          referenceId: event.referenceId,
        );

        final failure = extractLeft(result);
        if (failure != null) return emit(OrderError(failure.message));

        emit(PaymentVerified(extractRight(result)));
      }
    });
  }
}
