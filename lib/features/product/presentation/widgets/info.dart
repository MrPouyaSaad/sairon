import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/themes/app_colors.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? price section
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.primaryColor.withOpacity(0.75),
                border: Border.all(color: AppColors.primaryColor, width: 1),
              ),
              child: Text(
                '${productEntity.discount}%',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Gap(16),
            Text(
              productEntity.orginalPrice.formattedStringPrice.withPriceLable,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                decoration: productEntity.discount.isEmpty
                    ? null
                    : TextDecoration.lineThrough,
              ),
            ),
            Gap(8),
            Text(
              productEntity.discountedPrice.formattedStringPrice.withPriceLable,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        //? title section
        Gap(12),
        Text(
          productEntity.name,

          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            wordSpacing: -1,
            color: AppColors.textPrimary,
          ),
        ),

        Gap(12),
        //? stock
        Row(
          children: [
            productEntity.stock != '0'
                ? Icon(
                    Iconsax.verify5,
                    size: 20,
                    color: Colors.greenAccent[700],
                  )
                : Icon(
                    Iconsax.close_circle5,
                    size: 20,
                    color: Colors.redAccent[700],
                  ),
            Gap(4),
            Text(
              productEntity.stock != '0'
                  ? "موجود در انبار"
                  : "ناموجود در انبار",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                wordSpacing: -1,
                color: productEntity.stock != '0'
                    ? Colors.greenAccent[700]
                    : Colors.redAccent[700],
              ),
            ),
          ],
        ),
        Gap(32),
        //? variant
        ...productEntity.variants.map(
          (variant) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'انتخاب ${variant.attributes.entries.first.key}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
              Gap(8),
              ...variant.attributes.entries.map(
                (entry) => Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: Constants.primaryRadius,
                    color: AppColors.textSecondary,
                    border: Border.all(width: 2, color: AppColors.textPrimary),
                  ),
                  child: Text(
                    entry.value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Gap(32),
        //? attributes
        Text(
          'مشخصات فنی',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        Gap(8),
        ...productEntity.attributes.map(
          (attribute) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(attribute.name), Text(attribute.value)],
          ),
        ),
        Gap(32),
        Text(
          'توضیحات',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        Gap(8),
        Text(
          productEntity.description,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            wordSpacing: -1,
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    ).marginSymmetric(horizontal: 24);
  }
}
