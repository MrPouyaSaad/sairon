import 'package:flutter/cupertino.dart';
import 'package:sairon/features/cart/domain/entities/cart_item.dart';
import 'package:sairon/features/cart/presentation/widgets/cart_item.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key, required this.items});
  final List<CartItemEntity> items;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => CartItemWidget(item: items[index]),
    );
  }
}
