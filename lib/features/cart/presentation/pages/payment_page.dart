import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('پرداخت')),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('بازگشت'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
