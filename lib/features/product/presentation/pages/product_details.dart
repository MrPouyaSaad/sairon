import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/features/auth/data/repositories/token_repo.dart';
import 'package:sairon/features/auth/presentation/pages/auth_bloc_wrapper.dart';
import 'package:sairon/features/cart/data/repository/cart_repository_impl.dart';
import 'package:sairon/features/cart/domain/usecase/cart_usecases.dart';
import 'package:sairon/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/presentation/widgets/recommended_products.dart';
import 'package:get/get.dart';
import '../../domain/entities/variants.dart';
import '../widgets/appbar_back_button.dart';
import '../widgets/discount_label.dart';
import '../widgets/product_info.dart';
import '../widgets/product_main_image.dart';
import '../widgets/rate.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? selectedVariantId;

  void addToCart(BuildContext context) {
    final variantId =
        selectedVariantId ?? widget.productEntity.variants.firstOrNull?.id;

    context.read<CartBloc>().add(
      CartAdd(
        productId: widget.productEntity.id.toString(),
        quantity: 1,
        variantId: variantId,
      ),
    );
  }

  bool isInCart(CartState state) {
    if (state is! CartLoaded) return false;

    return state.cart!.items.any(
      (i) =>
          i.product.id == widget.productEntity.id &&
          i.variant?.id == selectedVariantId,
    );
  }

  void changeQty({required bool inc}) {
    final cart = context.read<CartBloc>().state;
    if (cart is! CartLoaded) return;

    final item = cart.cart!.items.firstWhereOrNull(
      (i) =>
          i.product.id == widget.productEntity.id &&
          i.variant?.id == selectedVariantId,
    );
    if (item == null) return;

    final newQty = inc ? item.quantity + 1 : item.quantity - 1;

    if (newQty <= 0) {
      context.read<CartBloc>().add(CartRemove(item.id));
    } else {
      context.read<CartBloc>().add(
        CartIncrease(itemId: item.id, quantity: newQty),
      );
    }
  }

  void onVariantSelected(String? variantId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedVariantId = variantId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasVariants = widget.productEntity.variants.isNotEmpty;

    ProductVariantEntity? selectedVariant;
    if (hasVariants) {
      if (selectedVariantId != null) {
        selectedVariant = widget.productEntity.variants.firstWhereOrNull(
          (v) => v.id == selectedVariantId,
        );
      }
      selectedVariant ??= widget.productEntity.variants.firstOrNull;
    }

    final originalPrice = hasVariants && selectedVariant != null
        ? (double.tryParse(selectedVariant.price) ?? 0).toInt()
        : (double.tryParse(widget.productEntity.orginalPrice) ?? 0).toInt();

    final discountPercent = int.tryParse(widget.productEntity.discount) ?? 0;
    final discountedPrice = discountPercent > 0
        ? (originalPrice * (100 - discountPercent)) ~/ 100
        : originalPrice;

    return BlocProvider(
      create: (context) => CartBloc(CartUsecases(repository: cartRepository)),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ProductMainImage(productEntity: widget.productEntity),
                    const AppBarBackButton(),
                    DiscountLabel(discount: widget.productEntity.discount),
                  ],
                ),
                const Gap(8),
                const RateSection(),
                const Gap(16),
                ProductInfo(
                  productEntity: widget.productEntity,
                  onVariantSelected: onVariantSelected,
                ),
                const Gap(24),
                RecommendedProducts(id: widget.productEntity.id),
                const Gap(100),
              ],
            ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ValueListenableBuilder(
          valueListenable: TokenRepository.tokenNotifier,
          builder: (context, value, child) {
            if (value == null) {
              return FloatingActionButton.extended(
                onPressed: () {
                  Get.to(AuthWrapper());
                },
                label: Row(
                  children: [
                    Text('برای خرید ابتدا وارد شوید'),
                    Gap(16),
                    Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              );
            } else {
              return BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final isLoading = state is CartLoading;
                  final inCart = isInCart(state);

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: widget.productEntity.stock == '0'
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary,
                              borderRadius: Constants.primaryRadius,
                            ),
                            child: Text(
                              'ناموجود',
                              style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : !inCart
                        ? FloatingActionButton.extended(
                            key: const ValueKey('addButton'),
                            onPressed: isLoading
                                ? null
                                : () => addToCart(context),
                            icon: isLoading
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.add_shopping_cart),
                            label: isLoading
                                ? const Text('در حال افزودن...')
                                : const Text('افزودن به سبد خرید'),
                          )
                        : const SizedBox.shrink(),
                  );
                },
              );
            }
          },
        ),

        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final isLoading = state is CartLoading;
            final inCart = isInCart(state);

            if (state is! CartLoaded || !inCart) {
              return const SizedBox.shrink();
            }

            final item = state.cart!.items.firstWhereOrNull(
              (i) =>
                  i.product.id == widget.productEntity.id &&
                  i.variant?.id == selectedVariantId,
            );

            if (item == null) {
              return const SizedBox.shrink();
            }

            final count = item.quantity;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => SizeTransition(
                sizeFactor: anim,
                axisAlignment: -1,
                child: child,
              ),
              child: BottomAppBar(
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
                          if (!isLoading) ...[
                            GestureDetector(
                              onTap: () => changeQty(inc: true),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.textPrimary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Iconsax.add,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                            const Gap(16),
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(16),
                            GestureDetector(
                              onTap: () => changeQty(inc: false),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: count > 1
                                      ? AppColors.textSecondary
                                      : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  count > 1 ? Iconsax.minus : Iconsax.trash,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ] else
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.primary,
                                ),
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
                              originalPrice.toString().formattedStringPrice,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Gap(8),
                          Text(
                            (discountedPrice * count)
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
              ),
            );
          },
        ),
      ),
    );
  }
}
