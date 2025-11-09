import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'checkout_page.dart';
import 'payment_page.dart';

class CartFlowScreen extends StatefulWidget {
  const CartFlowScreen({super.key});

  @override
  State<CartFlowScreen> createState() => _CartFlowScreenState();
}

class _CartFlowScreenState extends State<CartFlowScreen> {
  final navigatorKey = GlobalKey<NavigatorState>();
  int currentStep = 0;

  void _updateStepByRoute(String routeName) {
    int newStep = 0;
    if (routeName.contains('checkout')) newStep = 1;
    if (routeName.contains('payment')) newStep = 2;

    if (currentStep != newStep) {
      // ایمن‌تر: setState بعد از build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => currentStep = newStep);
      });
    }
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case '/checkout':
        page = const CheckoutPage();
        break;
      case '/payment':
        page = const PaymentPage();
        break;
      case '/cart':
      default:
        page = const CartPage();
        break;
    }

    // بعد از ساخت route، مرحله رو تغییر بده
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStepByRoute(settings.name ?? '');
    });

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(child: _CartProgressHeader(currentStep: currentStep)),
      ),
      body: Navigator(
        key: const ValueKey('cart_flow_navigator'),
        initialRoute: '/cart',
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}

class _CartProgressHeader extends StatelessWidget {
  final int currentStep;
  const _CartProgressHeader({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const steps = ['سبد خرید', 'مشخصات ارسال', 'پرداخت'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (i) {
          final active = i <= currentStep;

          return Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        color: i == 0
                            ? Colors.transparent
                            : (active ? Colors.green : Colors.grey[300]),
                      ),
                    ),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: active ? Colors.green : Colors.grey[300],
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          color: active ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: i == 2
                            ? Colors.transparent
                            : (i < currentStep
                                  ? Colors.green
                                  : Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  steps[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                    color: active ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
