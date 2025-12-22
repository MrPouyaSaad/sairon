import 'package:flutter/material.dart';

import '../../data/models/order_model.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  final bool isExpanded;

  const OrderItemWidget({
    super.key,
    required this.order,
    this.onTap,
    this.isExpanded = false,
  });

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(OrderItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() => _expanded = widget.isExpanded);
    }
  }

  String _formatPrice(double price) {
    return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} تومان';
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}/${date.month}/${date.day} - ${date.hour}:${date.minute}';
    } catch (_) {
      return dateString;
    }
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    final map = {
      'pending_payment': {'text': 'در انتظار پرداخت', 'color': Colors.amber},
      'paid': {'text': 'پرداخت شده', 'color': Colors.green},
      'processing': {'text': 'در حال پردازش', 'color': Colors.blue},
      'preparing': {'text': 'در حال آماده‌سازی', 'color': Colors.purple},
      'shipped': {'text': 'ارسال شده', 'color': Colors.orange},
      'delivered': {'text': 'تحویل شده', 'color': Colors.green.shade700},
      'cancelled': {'text': 'لغو شده', 'color': Colors.red},
    };

    return map[status] ?? {'text': 'نامشخص', 'color': Colors.grey};
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final info = _getStatusInfo(order.status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        key: Key(order.id),
        initiallyExpanded: _expanded,
        onExpansionChanged: (expanded) {
          setState(() => _expanded = expanded);
          widget.onTap?.call();
        },
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Number + Status
                  Row(
                    children: [
                      Text(
                        'سفارش #${order.orderNumber}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: info['color'].withOpacity(.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          info['text'],
                          style: TextStyle(
                            color: info['color'],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Date + Price
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(order.createdAt.toString()),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatPrice(order.total),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          // --- Items ---
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'محصولات',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                ...order.items.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        // Image
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(item.product.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Title + Quantity
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'تعداد: ${item.quantity}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatPrice(item.unitPrice * item.quantity),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (item.originalPrice > item.unitPrice)
                              Text(
                                _formatPrice(
                                  item.originalPrice * item.quantity,
                                ),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // --- Summary ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _summary('جمع کل', _formatPrice(order.subtotal)),
                if (order.discount > 0)
                  _summary(
                    'تخفیف',
                    '-${_formatPrice(order.discount)}',
                    color: Colors.green,
                  ),
                _summary(
                  'هزینه ارسال',
                  order.shippingCost == 0
                      ? 'رایگان'
                      : _formatPrice(order.shippingCost),
                  color: order.shippingCost == 0
                      ? Colors.green
                      : Colors.black87,
                ),
                const Divider(),
                _summary(
                  'مبلغ نهایی',
                  _formatPrice(order.total),
                  isBold: true,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summary(
    String title,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
