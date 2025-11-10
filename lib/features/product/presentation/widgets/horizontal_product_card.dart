// lib/features/product/presentation/widgets/horizontal_product_card.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sairon/core/themes/text_styles.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/core/widgets/gradient.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    final isDiscounted = double.parse(productEntity.discount) > 0;

    return Container(
      width: 270,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProductImage(isDiscounted),

          Expanded(child: _buildProductInfo(isDiscounted)),
        ],
      ),
    );
  }

  Widget _buildProductImage(bool isDiscounted) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ImageLoadingService(
              imageUrl: productEntity.images.urls.first,
            ),
          ),
        ),

        if (isDiscounted)
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                gradient: GradientTheme.primaryGradient,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${productEntity.discount}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductInfo(bool isDiscounted) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // عنوان و توضیحات
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productEntity.name,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(4),
              Text(
                'توضیحات کوتاه محصول...',
                style: AppTextStyles.caption.copyWith(color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // قیمت و دکمه
          Column(
            children: [
              // قیمت
              Row(
                children: [
                  Text(
                    productEntity
                        .discountedPrice
                        .formattedStringPrice
                        .withPriceLable,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),

                  const Spacer(),

                  if (isDiscounted)
                    Text(
                      productEntity.orginalPrice.formattedStringPrice,
                      style: AppTextStyles.caption.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[500],
                      ),
                    ),
                ],
              ),

              const Gap(8),

              // دکمه افزودن به سبد
              Container(
                height: 32,
                decoration: BoxDecoration(
                  gradient: GradientTheme.buttonGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: _addToCart,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        const Gap(4),
                        Text(
                          'افزودن',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    // TODO: Add to cart logic
  }
}
