import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/cart/domain/entities/cart_item.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});
  // final CartItemEntity cart;
  @override
  Widget build(BuildContext context) {
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
                child: ImageLoadingService(
                  borderRadius: Constants.primaryRadius,
                  imageUrl:
                      'https://dkstatics-public.digikala.com/digikala-products/b9965d7e124d19605c5f78ad9b4759edfecda60d_1686128724.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/quality,q_90',
                ),
              ),
              Gap(12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'هولدر',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      wordSpacing: -1,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Gap(4),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'رنگ: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            wordSpacing: -1,
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'مشکی',
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
                    '2',
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
                  if (10 > 0)
                    Text(
                      '290000'.formattedStringPrice,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Gap(8),
                  Text(
                    '250000'.formattedStringPrice.withPriceLable,
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
