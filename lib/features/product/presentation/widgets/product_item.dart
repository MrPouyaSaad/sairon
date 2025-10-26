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

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productEntity});
  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    final isDiscounted = double.parse(productEntity.discount) > 0;
    final picSize = MediaQuery.of(context).size.width / 2.5;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 300,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: Constants.primaryRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: picSize,
                  height: picSize,
                  child: ImageLoadingService(
                    imageUrl: productEntity.images.images.first,
                  ),
                ).marginAll(12),
                if (isDiscounted)
                  if (isDiscounted)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: GradientTheme.primaryGradient,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              Constants.primaryRadiusValue,
                            ),
                            topRight: Radius.circular(
                              Constants.primaryRadiusValue,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.errorColor.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${productEntity.discount}%',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            Gap(18),
            Text(
              productEntity.name,
              style: AppTextStyles.bodyLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ).marginSymmetric(horizontal: 8),
            Gap(8),
            Text(
              (productEntity.orginalPrice).formattedStringPrice,
              style: AppTextStyles.caption.copyWith(
                decorationColor: Colors.grey,
                decoration: isDiscounted ? TextDecoration.lineThrough : null,
              ),
            ).marginSymmetric(horizontal: 8),

            Visibility(
              visible: isDiscounted,
              child: Text(
                (productEntity.discountedPrice)
                    .formattedStringPrice
                    .withPriceLable,
                style: AppTextStyles.bodyLarge,
              ),
            ).marginOnly(top: 2, left: 8, right: 8),
          ],
        ),
      ),
    );
  }
}
