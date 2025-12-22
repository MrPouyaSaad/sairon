import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/order/data/repositories/order_repo_impl.dart';
import 'package:sairon/features/order/domain/usecases/order_usecases.dart';
import 'package:sairon/features/order/presentation/bloc/order_bloc.dart';
import '../../../../core/widgets/gradient.dart';
import '../../../../core/widgets/gradient_appbar.dart';
import '../widgets/order_item.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int? expandedOrderId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => context.read<OrderBloc>().add(FetchOrders()),
    );
  }

  void _toggleOrder(int orderId) {
    setState(() {
      expandedOrderId = expandedOrderId == orderId ? null : orderId;
    });
  }

  Future<void> _refresh() async {
    context.read<OrderBloc>().add(FetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderBloc(OrderUseCases(repository: orderRepository))
            ..add(FetchOrders()),
      child: Scaffold(
        body: Column(
          children: [
            GradientAppBar(
              title: 'سفارش‌های من',
              gradient: GradientTheme.primaryGradient,
            ),
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  // --- Loading ---
                  if (state is OrderLoading) {
                    return Center(child: const ScreenLoadingIndicator());
                  }

                  // --- Error ---
                  if (state is OrderError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<OrderBloc>().add(FetchOrders()),
                            child: const Text("تلاش دوباره"),
                          ),
                        ],
                      ),
                    );
                  }

                  // --- Orders Loaded ---
                  if (state is OrdersLoaded) {
                    final orders = state.orders!;

                    if (orders.isEmpty) {
                      return const Center(child: Text("سفارشی یافت نشد"));
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 16),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return OrderItemWidget(
                            order: order,
                            isExpanded: expandedOrderId == int.parse(order.id),
                            onTap: () => _toggleOrder(int.parse(order.id)),
                          );
                        },
                      ),
                    );
                  }

                  // Default
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
