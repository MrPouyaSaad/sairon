import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/order/domain/usecases/order_usecases.dart';

import '../../data/models/order_model.dart';
import '../../data/models/order_preview_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCases useCases;

  OrderBloc(this.useCases) : super(OrderInitial()) {
    on<FetchOrders>(_onFetchOrders);
    on<FetchOrderDetails>(_onFetchOrderDetails);
    on<CreateOrder>(_onCreateOrder);
    on<CancelOrder>(_onCancelOrder);
    on<CalculateShipping>(_onCalculateShipping);
    on<GetPaymentToken>(_onGetPaymentToken);
    on<CheckPaymentStatus>(_onCheckPaymentStatus);
  }

  // ================= Orders =================

  Future<void> _onFetchOrders(
    FetchOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await useCases.fetchOrders(
      status: event.status,
      page: event.page,
      limit: event.limit,
    );

    final failure = extractLeft(result);
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    emit(OrdersLoaded(extractRight(result)));
  }

  Future<void> _onFetchOrderDetails(
    FetchOrderDetails event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await useCases.fetchOrderDetails(event.orderId);

    final failure = extractLeft(result);
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    emit(OrderDetailsLoaded(extractRight(result)));
  }

  // ================= Order Actions =================

  Future<void> _onCreateOrder(
    CreateOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

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
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    emit(OrderCreated(extractRight(result)));
  }

  Future<void> _onCancelOrder(
    CancelOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await useCases.cancelOrder(event.orderId);

    final failure = extractLeft(result);
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    emit(OrderCancelled());
  }

  // ================= Shipping =================

  Future<void> _onCalculateShipping(
    CalculateShipping event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await useCases.calculateOrderPreview(
      province: event.province,
      city: event.city,
    );

    final failure = extractLeft(result);
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    emit(ShippingCalculated(extractRight(result)));
  }

  // ================= Payment =================

  Future<void> _onGetPaymentToken(
    GetPaymentToken event,
    Emitter<OrderState> emit,
  ) async {
    emit(PaymentTokenLoading());

    final result = await useCases.getPaymentToken(
      orderId: event.orderId,
      amount: event.amount,
      phone: event.phone,
      redirectUrl: event.redirectUrl,
    );

    final failure = extractLeft(result);
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    emit(PaymentTokenLoaded(extractRight(result)));
  }

  Future<void> _onCheckPaymentStatus(
    CheckPaymentStatus event,
    Emitter<OrderState> emit,
  ) async {
    emit(PaymentChecking());

    final result = await useCases.checkPaymentStatus(event.orderId);

    final failure = extractLeft(result);
    if (failure != null) {
      emit(OrderError(failure.message));
      return;
    }

    final data = extractRight(result);

    if (data?['status'] == 'success') {
      emit(PaymentSuccess(data));
    } else {
      emit(PaymentFailed(data?['status']));
    }
  }
}
