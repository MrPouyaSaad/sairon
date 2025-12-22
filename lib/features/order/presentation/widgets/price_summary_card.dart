import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/features/cart/domain/entities/shipping_info.dart';

class PriceSummaryCard extends StatelessWidget {
  final double totalAmount;
  final double discount;
  final double payableAmount;
  final ShippingInfoEntity shippingInfoEntity;

  const PriceSummaryCard({
    super.key,
    required this.totalAmount,
    required this.discount,
    required this.shippingInfoEntity,
    required this.payableAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'خلاصه فاکتور',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPriceRow(
            context,
            title: 'جمع کل کالاها',
            price: totalAmount.formattedDoublePrice,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            context,
            title: 'تخفیف کالاها',
            price: discount.formattedDoublePrice,
            color: AppColors.successColor,
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            context,
            title: 'هزینه ارسال',
            price: (double.parse(
              shippingInfoEntity.cost.toString(),
            )).formattedDoublePrice,
            color: AppColors.successColor,
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ قابل پرداخت',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                payableAmount.formattedDoublePrice,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context, {
    required String title,
    required String price,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          price,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
