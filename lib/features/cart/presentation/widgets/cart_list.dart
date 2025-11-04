import 'package:flutter/cupertino.dart';
import 'package:sairon/features/cart/presentation/widgets/cart_item.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) => CartItem(),
    );
  }
}
