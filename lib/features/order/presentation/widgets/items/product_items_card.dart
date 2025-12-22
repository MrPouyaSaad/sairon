import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/cart/data/repository/cart_repository_impl.dart';

class ProductItemsCard extends StatelessWidget {
  const ProductItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: cartRepository.cartNotifier,
      builder: (context, cart, child) {
        if (cart!.items.isEmpty) {
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
            child: Center(
              child: Text(
                'سبد خرید شما خالی است',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

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
                      color: AppColors.accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.accentColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'محصولات',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${cart.items.length} کالا',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ...cart.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final product = item.product;

                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.backgroundColor,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: product.images.urls.isNotEmpty
                              ? ImageLoadingService(
                                  imageUrl: product.images.urls.first,
                                )
                              : const Icon(
                                  Icons.image_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),

                              // // نمایش مشخصات variant اگر وجود داشته باشد
                              // if (item.variant != null) ...[
                              //   if (item.variant!. != null &&
                              //       item.variant!.color!.isNotEmpty)
                              //     Text(
                              //       'رنگ: ${item.variant!.color}',
                              //       style: TextStyle(
                              //         color: AppColors.textSecondary,
                              //         fontSize: 12,
                              //       ),
                              //     ),

                              //   // نمایش سایز
                              //   if (item.variant!.size != null &&
                              //       item.variant!.size!.isNotEmpty)
                              //     Text(
                              //       'سایز: ${item.variant!.size}',
                              //       style: TextStyle(
                              //         color: AppColors.textSecondary,
                              //         fontSize: 12,
                              //       ),
                              //     ),
                              // ],
                              Row(
                                children: [
                                  if (product.discount != '0')
                                    Text(
                                      '${product.orginalPrice} تومان',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  if (product.discount != '0')
                                    const SizedBox(width: 8),
                                  Text(
                                    '${product.discountedPrice} تومان',
                                    style: TextStyle(
                                      color: product.discount != '0'
                                          ? Colors.red
                                          : AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // قیمت و تعداد
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${item.totalPrice} تومان',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.quantity} عدد',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    if (index < cart.items.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1),
                      ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
