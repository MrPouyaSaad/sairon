import 'package:flutter/material.dart';

import '../widgets/order_item.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;
  int? expandedOrderId;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    await Future.delayed(const Duration(seconds: 1));

    // داده نمونه - در برنامه واقعی از API دریافت می‌شود
    setState(() {
      orders = [
        {
          'id': 1,
          'orderNumber': 'ORD-2024-001',
          'status': 'delivered',
          'createdAt': '2024-01-15T10:30:00Z',
          'subtotal': 290000,
          'discount': 40000,
          'shippingCost': 0,
          'total': 250000,
          'paidAt': '2024-01-15T10:35:00Z',
          'deliveredAt': '2024-01-17T14:20:00Z',
          'items': [
            {
              'product': {
                'name': 'کفش ورزشی مردانه',
                'image': 'https://picsum.photos/200',
              },
              'quantity': 1,
              'unitPrice': 150000,
              'originalPrice': 180000,
            },
            {
              'product': {
                'name': 'جوراب ورزشی',
                'image': 'https://picsum.photos/201',
              },
              'quantity': 2,
              'unitPrice': 25000,
              'originalPrice': 30000,
            },
          ],
        },
        {
          'id': 2,
          'orderNumber': 'ORD-2024-002',
          'status': 'processing',
          'createdAt': '2024-01-14T15:45:00Z',
          'subtotal': 450000,
          'discount': 50000,
          'shippingCost': 25000,
          'total': 425000,
          'paidAt': '2024-01-14T15:50:00Z',
          'processingAt': '2024-01-14T16:30:00Z',
          'items': [
            {
              'product': {
                'name': 'لپ‌تاپ گیمینگ',
                'image': 'https://picsum.photos/202',
              },
              'quantity': 1,
              'unitPrice': 450000,
              'originalPrice': 500000,
            },
          ],
        },
        {
          'id': 3,
          'orderNumber': 'ORD-2024-003',
          'status': 'pending_payment',
          'createdAt': '2024-01-13T09:20:00Z',
          'subtotal': 120000,
          'discount': 20000,
          'shippingCost': 15000,
          'total': 115000,
          'items': [
            {
              'product': {
                'name': 'هدفون بی‌سیم',
                'image': 'https://picsum.photos/203',
              },
              'quantity': 1,
              'unitPrice': 120000,
              'originalPrice': 140000,
            },
          ],
        },
      ];
      isLoading = false;
    });
  }

  void _toggleOrder(int orderId) {
    setState(() {
      expandedOrderId = expandedOrderId == orderId ? null : orderId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سفارش‌های من'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadOrders,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderItem(
                    order: order,
                    isExpanded: expandedOrderId == order['id'],
                    onTap: () => _toggleOrder(order['id']),
                  );
                },
              ),
            ),
    );
  }
}
