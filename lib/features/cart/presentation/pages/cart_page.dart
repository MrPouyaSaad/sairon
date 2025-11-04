import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sairon/features/cart/presentation/widgets/cart_list.dart';
import 'package:sairon/features/cart/presentation/widgets/cart_total.dart';
import '../../../../core/constants/app_constants.dart' show Constants;
import '../../../../core/themes/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity - 48,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: Constants.primaryRadius,
            ),
          ),
          child: const Text(
            'ادامه خرید',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ).marginSymmetric(horizontal: 24),
      body: SafeArea(
        child: ListView.separated(
          itemCount: 2, // CartItemList , CartTotalWidget
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const CartItemList();
            } else {
              return const CartTotalWidget();
            }
          },
        ),
      ),
    );
  }
}
