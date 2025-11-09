import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('مشخصات ارسال')),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('ادامه به پرداخت'),
        onPressed: () {
          Navigator.of(context).pushNamed('/payment');
        },
      ),
    );
  }
}
