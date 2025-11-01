import 'package:flutter/material.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/cart/domain/entities/cart_item.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cart});
  final CartItemEntity cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: Constants.primaryRadius),
      child: Row(
        children: [
          ImageLoadingService(imageUrl: cart.productEntity.image),
          Text(cart.productEntity.name),
        ],
      ),
    );
  }
}
