import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/presentation/widgets/recommended_products.dart';

import '../widgets/info.dart';
import '../widgets/product_main_image.dart';
import '../widgets/rate.dart';

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
    if (count > 1) {
      setState(() => count--);
    } else {
      setState(() => addedToCart = false);
    }
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
              Gap(24),
              RecommendedProducts(id: widget.productEntity.id),
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
