import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/core/widgets/image_loading.dart';

import '../../domain/entities/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.item});
  final CartItemEntity item;

  String? _getProductImage() {
    if (item.product.images.urls.isNotEmpty) {
      return item.product.images.urls.first;
    }
    return item.product.image.isNotEmpty ? item.product.image : null;
  }

  String? _getVariantAttribute() {
    if (item.variant != null && item.variant!.attributes.isNotEmpty) {
      return item.variant!.attributes.values.first;
    }
    return null;
  }

  int _getOriginalPrice() {
    if (item.variant != null) {
      return int.tryParse(item.variant!.price) ?? 0;
    }
    return int.tryParse(item.product.orginalPrice) ?? 0;
  }

  int _getDiscountedPrice() {
    return item.currentPrice;
  }

  bool _hasDiscount() {
    final originalPrice = _getOriginalPrice();
    final discountedPrice = _getDiscountedPrice();
    return discountedPrice < originalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final originalPrice = _getOriginalPrice();
    final discountedPrice = _getDiscountedPrice();
    final hasDiscount = _hasDiscount();
    final variantAttribute = _getVariantAttribute();
    final productImage = _getProductImage();

    return Container(
      decoration: BoxDecoration(borderRadius: Constants.primaryRadius),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: Constants.primaryRadius,
                  color: AppColors.primaryColor.withOpacity(0.25),
                ),
                child: productImage != null
                    ? ImageLoadingService(
                        borderRadius: Constants.primaryRadius,
                        imageUrl: productImage,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: Constants.primaryRadius,
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Iconsax.shopping_cart,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
              ),
              Gap(12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        wordSpacing: -1,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4),
                    if (variantAttribute != null)
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: '${item.variant!.attributes.keys.first}: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                wordSpacing: -1,
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text: variantAttribute,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    wordSpacing: -1,
                                    fontSize: 12,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondaryColor),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.minus,
                      color: AppColors.secondaryColor,
                      size: 22,
                    ),
                  ),
                  Gap(16),
                  Text(
                    item.quantity.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(16),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Iconsax.add, color: Colors.white, size: 22),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (hasDiscount)
                    Text(
                      (originalPrice * item.quantity)
                          .toString()
                          .formattedStringPrice,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        decorationColor: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  if (hasDiscount) Gap(8),
                  Text(
                    (discountedPrice * item.quantity)
                        .toString()
                        .formattedStringPrice
                        .withPriceLable,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ).marginOnly(right: 76, top: 8),
          Divider().marginSymmetric(vertical: 16),
        ],
      ).marginSymmetric(horizontal: 24),
    );
  }
}
