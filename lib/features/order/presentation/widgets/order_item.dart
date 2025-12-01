import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onTap;
  final bool isExpanded;

  const OrderItem({
    Key? key,
    required this.order,
    this.onTap,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(OrderItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        _expanded = widget.isExpanded;
      });
    }
  }

  String _formatPrice(double price) {
    return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} تومان';
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final persianMonths = [
        'فروردین',
        'اردیبهشت',
        'خرداد',
        'تیر',
        'مرداد',
        'شهریور',
        'مهر',
        'آبان',
        'آذر',
        'دی',
        'بهمن',
        'اسفند',
      ];
      return '${date.day} ${persianMonths[date.month - 1]} ${date.year} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    final statusMap = {
      'pending_payment': {
        'text': 'در انتظار پرداخت',
        'color': Colors.amber,
        'bgColor': Colors.amber.shade50,
        'borderColor': Colors.amber.shade200,
        'icon': '⏳',
      },
      'paid': {
        'text': 'پرداخت شده',
        'color': Colors.green,
        'bgColor': Colors.green.shade50,
        'borderColor': Colors.green.shade200,
        'icon': '✅',
      },
      'processing': {
        'text': 'در حال پردازش',
        'color': Colors.blue,
        'bgColor': Colors.blue.shade50,
        'borderColor': Colors.blue.shade200,
        'icon': '⚙️',
      },
      'preparing': {
        'text': 'در حال آماده‌سازی',
        'color': Colors.purple,
        'bgColor': Colors.purple.shade50,
        'borderColor': Colors.purple.shade200,
        'icon': '📦',
      },
      'shipped': {
        'text': 'تحویل به پست',
        'color': Colors.orange,
        'bgColor': Colors.orange.shade50,
        'borderColor': Colors.orange.shade200,
        'icon': '🚚',
      },
      'delivered': {
        'text': 'تحویل داده شده',
        'color': Colors.green.shade700,
        'bgColor': Colors.green.shade50,
        'borderColor': Colors.green.shade200,
        'icon': '🎉',
      },
      'cancelled': {
        'text': 'لغو شده',
        'color': Colors.red,
        'bgColor': Colors.red.shade50,
        'borderColor': Colors.red.shade200,
        'icon': '❌',
      },
    };

    return statusMap[status] ??
        {
          'text': status,
          'color': Colors.grey,
          'bgColor': Colors.grey.shade50,
          'borderColor': Colors.grey.shade200,
          'icon': '❓',
        };
  }

  List<Map<String, dynamic>> _getOrderSteps(Map<String, dynamic> order) {
    final steps = [
      {
        'name': 'پرداخت',
        'key': 'payment',
        'status': 'pending',
        'date': order['paidAt'],
        'targetStatus': 'paid',
      },
      {
        'name': 'در حال پردازش',
        'key': 'processing',
        'status': 'pending',
        'date': order['processingAt'],
        'targetStatus': 'processing',
      },
      {
        'name': 'آماده‌سازی',
        'key': 'preparing',
        'status': 'pending',
        'date': order['preparingAt'],
        'targetStatus': 'preparing',
      },
      {
        'name': 'تحویل به پست',
        'key': 'shipped',
        'status': 'pending',
        'date': order['shippedAt'],
        'targetStatus': 'shipped',
      },
      {
        'name': 'تحویل داده شد',
        'key': 'delivered',
        'status': 'pending',
        'date': order['deliveredAt'],
        'targetStatus': 'delivered',
      },
    ];

    final statusOrder = {
      'pending_payment': 0,
      'paid': 1,
      'processing': 2,
      'preparing': 3,
      'shipped': 4,
      'delivered': 5,
      'cancelled': -1,
    };

    final currentStatusIndex = statusOrder[order['status']] ?? 0;

    if (order['status'] == 'cancelled') {
      steps.forEach((step) {
        step['status'] = 'cancelled';
      });
      return steps;
    }

    for (var i = 0; i < steps.length; i++) {
      if (i < currentStatusIndex) {
        steps[i]['status'] = 'completed';
        if (i == 0 && order['paidAt'] != null)
          steps[i]['date'] = order['paidAt'];
        if (i == 1 && order['processingAt'] != null)
          steps[i]['date'] = order['processingAt'];
        if (i == 2 && order['preparingAt'] != null)
          steps[i]['date'] = order['preparingAt'];
        if (i == 3 && order['shippedAt'] != null)
          steps[i]['date'] = order['shippedAt'];
        if (i == 4 && order['deliveredAt'] != null)
          steps[i]['date'] = order['deliveredAt'];
      } else if (i == currentStatusIndex) {
        steps[i]['status'] = 'current';
      } else {
        steps[i]['status'] = 'pending';
      }
    }

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final statusInfo = _getStatusInfo(order['status']);
    final steps = _getOrderSteps(order);
    final completedSteps = steps
        .where((step) => step['status'] == 'completed')
        .length;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          key: Key(order['id'].toString()),
          initiallyExpanded: _expanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _expanded = expanded;
            });
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          childrenPadding: EdgeInsets.zero,
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'سفارش #${order['orderNumber'] ?? order['id']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusInfo['bgColor'],
                            border: Border.all(
                              color: statusInfo['borderColor'],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(statusInfo['icon']),
                              const SizedBox(width: 4),
                              Text(
                                statusInfo['text'],
                                style: TextStyle(
                                  color: statusInfo['color'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(order['createdAt']),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '250,000',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
          trailing: AnimatedRotation(
            turns: _expanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: const Icon(Icons.keyboard_arrow_down, size: 24),
          ),
          children: [
            Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            const SizedBox(height: 16),

            // استپر سفارش
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'روند سفارش',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      // خط پیش‌زمینه
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 2,
                            color: Colors.grey.shade300,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                      // خط فعال
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 2,
                            color: Colors.cyan,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: completedSteps > 0
                                ? MediaQuery.of(context).size.width *
                                      (completedSteps / (steps.length - 1)) *
                                      0.7
                                : 0,
                          ),
                        ),
                      ),
                      // مراحل
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: steps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final step = entry.value;
                          final isCompleted = step['status'] == 'completed';
                          final isCurrent = step['status'] == 'current';
                          final isCancelled = step['status'] == 'cancelled';

                          return Column(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isCompleted
                                      ? Colors.cyan
                                      : isCurrent
                                      ? Colors.cyan.shade700
                                      : isCancelled
                                      ? Colors.red
                                      : Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                  boxShadow: (isCompleted || isCurrent)
                                      ? [
                                          BoxShadow(
                                            color: Colors.cyan.withOpacity(0.3),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    isCompleted
                                        ? '✓'
                                        : isCancelled
                                        ? '✕'
                                        : '${index + 1}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                step['name'],
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: (isCompleted || isCurrent)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: (isCompleted || isCurrent)
                                      ? Colors.black
                                      : Colors.grey.shade600,
                                ),
                              ),
                              if (step['date'] != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(step['date']),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // محصولات
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'محصولات سفارش',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(order['items']?.length ?? 0, (index) {
                    final item = order['items'][index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                              image: item['product']?['image'] != null
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        item['product']['image'],
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['product']?['name'] ?? 'محصول',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'تعداد: ${item['quantity']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '258000',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatPrice(
                                  (item['unitPrice'] ?? item['price'] ?? 0) *
                                      (item['quantity'] ?? 1),
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (item['originalPrice'] >
                                  (item['unitPrice'] ?? item['price']))
                                Text(
                                  _formatPrice(
                                    item['originalPrice'] *
                                        (item['quantity'] ?? 1),
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

            // خلاصه سفارش
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'خلاصه سفارش',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      _buildSummaryRow(
                        'جمع کل',
                        _formatPrice(order['subtotal']),
                        isBold: false,
                      ),
                      if (order['discount'] > 0)
                        _buildSummaryRow(
                          'تخفیف',
                          '-${_formatPrice(order['discount'])}',
                          color: Colors.green,
                        ),
                      _buildSummaryRow(
                        'هزینه ارسال',
                        order['shippingCost'] == 0
                            ? 'رایگان'
                            : _formatPrice(order['shippingCost']),
                        color: order['shippingCost'] == 0 ? Colors.green : null,
                      ),
                      Divider(
                        height: 24,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      _buildSummaryRow(
                        'مبلغ قابل پرداخت',
                        _formatPrice(order['total']),
                        isBold: true,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // دکمه‌های اقدام
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'مشاهده جزئیات',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'خرید مجدد',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
