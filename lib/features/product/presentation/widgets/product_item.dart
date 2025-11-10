// lib/features/product/presentation/widgets/modern_product_card.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/themes/text_styles.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/core/widgets/gradient.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/presentation/pages/product_details.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    final isDiscounted = double.parse(productEntity.discount) > 0;
    final cardWidth = MediaQuery.of(context).size.width / 2 - 24;

    return GestureDetector(
      onTap: () => Get.to(ProductDetails(productEntity: productEntity)),
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(context, isDiscounted, cardWidth),

            _buildProductInfo(isDiscounted),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(
    BuildContext context,
    bool isDiscounted,
    double width,
  ) {
    return Stack(
      children: [
        Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: ImageLoadingService(
              imageUrl: productEntity.images.urls.first,
            ),
          ),
        ),

        if (isDiscounted)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: GradientTheme.primaryGradient,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.errorColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '${productEntity.discount}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductInfo(bool isDiscounted) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productEntity.name,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).marginSymmetric(horizontal: 12, vertical: 8),

          _buildPriceSection(isDiscounted),
        ],
      ),
    );
  }

  Widget _buildPriceSection(bool isDiscounted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isDiscounted)
          Text(
            productEntity.orginalPrice.formattedStringPrice,
            style: AppTextStyles.caption.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey.shade500,
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ).marginOnly(right: 12),

        const MaxGap(50),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: GradientTheme.cardGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Constants.primaryRadiusValue),
              topRight: Radius.circular(Constants.primaryRadiusValue),
            ),
          ),
          child: GradientText(
            productEntity.discountedPrice.formattedStringPrice.withPriceLable,
          ),
        ),
      ],
    );
  }
}
