import 'package:flutter/material.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/features/cart/domain/entities/cart.dart';

class CartTotalWidget extends StatelessWidget {
  const CartTotalWidget({super.key, required this.cart});
  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final int itemCount = cart.totalQuantity;
    final int totalPrice = cart.total.total;
    final int subTotal = cart.total.subTotal;
    final int shipping = cart.total.shipping;
    final int tax = cart.total.tax;
    final bool hasDiscount = subTotal > totalPrice - shipping - tax;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Constants.primaryRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'خلاصه سبد خرید',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تعداد آیتم‌ها:',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              Text(
                '$itemCount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'جمع سبد خرید:',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              Text(
                subTotal.toString().formattedStringPrice.withPriceLable,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'هزینه ارسال:',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              Text(
                shipping.toString().formattedStringPrice.withPriceLable,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          if (tax > 0)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مالیات:',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      tax.toString().formattedStringPrice.withPriceLable,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),

          Divider(color: AppColors.textSecondary.withOpacity(0.3), height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ قابل پرداخت:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (hasDiscount)
                    Text(
                      (subTotal + shipping + tax)
                          .toString()
                          .formattedStringPrice,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Text(
                    totalPrice.toString().formattedStringPrice.withPriceLable,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (cart.shippingInfo.message.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: Constants.primaryRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          cart.shippingInfo.message,

                          style: TextStyle(
                            wordSpacing: -1,
                            fontSize: 12,
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
