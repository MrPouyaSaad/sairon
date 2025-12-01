import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'checkout_page.dart';
import 'payment_page.dart';
import 'package:sairon/core/widgets/gradient.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStepByRoute(settings.name ?? '');
    });

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: _CartProgressHeader(currentStep: currentStep),
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
      decoration: const BoxDecoration(
        gradient: GradientTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              const Text(
                'تکمیل سفارش',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (i) {
                  final active = i <= currentStep;
                  final completed = i < currentStep;

                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: i == 0
                                      ? null
                                      : (completed
                                            ? GradientTheme.accentGradient
                                            : (active
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Colors.white,
                                                        Colors.white54,
                                                      ],
                                                    )
                                                  : LinearGradient(
                                                      colors: [
                                                        Colors.white
                                                            .withOpacity(0.3),
                                                        Colors.white
                                                            .withOpacity(0.1),
                                                      ],
                                                    ))),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: active
                                    ? GradientTheme.accentGradient
                                    : LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.3),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                      ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2,
                                ),
                                boxShadow: active
                                    ? [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF67E8F9,
                                          ).withOpacity(0.4),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: completed
                                    ? const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : Text(
                                        '${i + 1}',
                                        style: TextStyle(
                                          color: active
                                              ? Colors.white
                                              : Colors.white70,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: i == 2
                                      ? null
                                      : (completed
                                            ? GradientTheme.accentGradient
                                            : (active
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Colors.white54,
                                                        Colors.white,
                                                      ],
                                                    )
                                                  : LinearGradient(
                                                      colors: [
                                                        Colors.white
                                                            .withOpacity(0.1),
                                                        Colors.white
                                                            .withOpacity(0.3),
                                                      ],
                                                    ))),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          steps[i],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: active
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Colors.white,
                            shadows: active
                                ? [
                                    const Shadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
