import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';

import '../widgets/product_main_image.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool addedToCart = false;
  int count = 1;

  void addToCart() => setState(() => addedToCart = true);
  void increase() => setState(() => count++);
  void decrease() {
    if (count > 1)
      setState(() => count--);
    else
      setState(() => addedToCart = false);
  }

  @override
  Widget build(BuildContext context) {
    final int price = 310000;
    final int discountPercent = 10;
    final discountedPrice = (price * (100 - discountPercent)) ~/ 100;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductMainImage(productEntity: widget.productEntity),
                  AppBarBackButton(),
                ],
              ),
              Gap(8),
              RateSection(),
              Gap(16),
              ProductInfo(productEntity: widget.productEntity),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: !addedToCart
            ? FloatingActionButton.extended(
                key: const ValueKey('addButton'),
                onPressed: addToCart,
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('افزودن به سبد'),
              )
            : const SizedBox.shrink(),
      ),

      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            SizeTransition(sizeFactor: anim, axisAlignment: -1, child: child),
        child: addedToCart
            ? BottomAppBar(
                key: const ValueKey('cartBar'),
                elevation: 12,
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              color: AppColors.textPrimary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.add,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Gap(16),

                          Text(
                            '$count',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(16),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.minus,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (discountPercent > 0)
                            Text(
                              price.toString().formattedStringPrice,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Gap(8),
                          Text(
                            discountedPrice
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
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

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

class RateSection extends StatelessWidget {
  const RateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
        ).marginSymmetric(horizontal: 16),
        MaxGap(1000),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "(124)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  fontFamily: 'Yekan',
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: " 4.5",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Yekan',
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Gap(8),
        Icon(Iconsax.star5, color: Colors.amber, size: 22),
        Gap(24),
      ],
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Constants.primaryRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: BackButton(),
      ),
    );
  }
}
