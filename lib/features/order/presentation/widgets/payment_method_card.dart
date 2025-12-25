import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';

enum PaymentMethod { sepr, wallet, cash }

class PaymentMethodCard extends StatefulWidget {
  final Function(PaymentMethod) onMethodSelected;

  const PaymentMethodCard({super.key, required this.onMethodSelected});

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  PaymentMethod _selectedMethod = PaymentMethod.sepr;

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {
        'method': PaymentMethod.sepr,
        'icon': 'assets/images/Logo.png',
        'title': 'درگاه پرداخت سپ',
        'subtitle': 'پرداخت امن با تمامی کارت‌ها',
      },
    ];

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
                  color: AppColors.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.payment_outlined,
                  color: AppColors.successColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'روش پرداخت',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...paymentMethods.map((method) {
            final isSelected = _selectedMethod == method['method'];
            final isDisabled = method['isDisabled'] == true;

            return Column(
              children: [
                GestureDetector(
                  onTap: isDisabled
                      ? null
                      : () {
                          setState(() {
                            _selectedMethod = method['method'] as PaymentMethod;
                          });
                          widget.onMethodSelected(_selectedMethod);
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                      color: isSelected
                          ? AppColors.primaryColor.withOpacity(0.05)
                          : isDisabled
                          ? Colors.grey.shade50
                          : Colors.white,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.backgroundColor
                                : isDisabled
                                ? Colors.grey.shade300
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            method['icon'] as String,
                            width: 42,
                            height: 42,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method['title'] as String,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : isDisabled
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                              ),
                              Text(
                                method['subtitle'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDisabled
                                      ? Colors.grey
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Radio<PaymentMethod>(
                          value: method['method'] as PaymentMethod,
                          groupValue: _selectedMethod,
                          onChanged: isDisabled
                              ? null
                              : (value) {
                                  setState(() {
                                    _selectedMethod = value!;
                                  });
                                  widget.onMethodSelected(value!);
                                },
                          activeColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                if (method != paymentMethods.last) const SizedBox(height: 12),
              ],
            );
          }),
        ],
      ),
    );
  }
}
