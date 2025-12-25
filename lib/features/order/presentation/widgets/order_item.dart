import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/themes/text_styles.dart';
import 'package:sairon/core/widgets/gradient.dart';
import 'package:sairon/core/widgets/image_loading.dart';
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
      return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return dateString;
    }
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    final map = {
      'pending_payment': {
        'text': 'در انتظار پرداخت',
        'color': AppColors.warningColor,
        'icon': Icons.payment,
      },
      'paid': {
        'text': 'پرداخت شده',
        'color': AppColors.successColor,
        'icon': Icons.check_circle,
      },
      'processing': {
        'text': 'در حال پردازش',
        'color': Colors.blueAccent,
        'icon': Icons.refresh,
      },
      'preparing': {
        'text': 'در حال آماده‌سازی',
        'color': Colors.purple,
        'icon': Icons.inventory,
      },
      'shipped': {
        'text': 'ارسال شده',
        'color': Colors.orange,
        'icon': Icons.local_shipping,
      },
      'delivered': {
        'text': 'تحویل شده',
        'color': Colors.green.shade700,
        'icon': Icons.done_all,
      },
      'cancelled': {
        'text': 'لغو شده',
        'color': AppColors.errorColor,
        'icon': Icons.cancel,
      },
    };

    return map[status] ??
        {'text': 'نامشخص', 'color': Colors.grey, 'icon': Icons.help};
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final info = _getStatusInfo(order.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        key: Key(order.id),
        initiallyExpanded: _expanded,
        onExpansionChanged: (expanded) {
          setState(() => _expanded = expanded);
          widget.onTap?.call();
        },
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: GradientTheme.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(info['icon'], color: Colors.white, size: 20),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Number
            Row(
              children: [
                GradientText(
                  '#${order.orderNumber}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        info['color'].withOpacity(0.8),
                        info['color'].withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: info['color'].withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(info['icon'], size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        info['text'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yekan',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date + Price
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(order.createdAt.toString()),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.1),
                        AppColors.secondaryColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GradientText(
                    _formatPrice(order.total),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          // --- Order Items ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'محصولات سفارش',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFe5e7eb)),

                // Products List
                ...order.items.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.surfaceColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor.withOpacity(0.1),
                                AppColors.secondaryColor.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: item.product.images.urls.isNotEmpty
                                ? ImageLoadingService(
                                    imageUrl: item.product.images.urls.first,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      gradient: GradientTheme.cardGradient,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.shopping_bag,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${item.quantity} عدد',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GradientText(
                                        _formatPrice(
                                          item.unitPrice * item.quantity,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (item.originalPrice > item.unitPrice)
                                        Text(
                                          _formatPrice(
                                            item.originalPrice * item.quantity,
                                          ),
                                          style: AppTextStyles.caption.copyWith(
                                            color: AppColors.textSecondary,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFe5e7eb)),

                // --- Order Summary ---
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_long_outlined,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'خلاصه سفارش',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _summaryRow(
                  'جمع کل',
                  _formatPrice(order.subtotal),
                  icon: Icons.shopping_cart_outlined,
                ),
                if (order.discount > 0)
                  _summaryRow(
                    'تخفیف',
                    '-${_formatPrice(order.discount)}',
                    color: AppColors.successColor,
                    icon: Icons.discount_outlined,
                  ),
                _summaryRow(
                  'هزینه ارسال',
                  order.shippingCost == 0
                      ? 'رایگان'
                      : _formatPrice(order.shippingCost),
                  color: order.shippingCost == 0
                      ? AppColors.successColor
                      : AppColors.textPrimary,
                  icon: Icons.local_shipping_outlined,
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, color: Color(0xFFe5e7eb)),
                _summaryRow(
                  'مبلغ نهایی',
                  _formatPrice(order.total),
                  isBold: true,
                  color: AppColors.primaryColor,
                  icon: Icons.payments_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    Color? color,
    bool isBold = false,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: color ?? AppColors.textSecondary),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isBold
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isBold
                  ? Border.all(color: AppColors.primaryColor.withOpacity(0.3))
                  : null,
            ),
            child: isBold
                ? GradientText(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: color ?? AppColors.textPrimary,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
