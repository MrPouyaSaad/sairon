// features/payment/presentation/pages/payment_page.dart
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/utils/extensions.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import 'package:sairon/features/order/data/repositories/order_repo_impl.dart';
import 'package:sairon/features/order/domain/entities/order_preview_entity.dart';
import 'package:sairon/features/order/domain/usecases/order_usecases.dart';
import 'package:sairon/features/order/presentation/bloc/order_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../data/models/order_model.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/price_summary_card.dart';
import '../widgets/items/product_items_card.dart';
import '../widgets/shipping_info_card.dart';
import '../widgets/terms_and_conditions.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.addressEntity});
  final AddressEntity addressEntity;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;
  bool _isCreatingOrder = false;
  PaymentMethod _selectedMethod = PaymentMethod.sepr;
  String? _createdOrderId;
  String? _paymentToken;

  @override
  void initState() {
    super.initState();
    _processInitialDeepLink();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _processInitialDeepLink() {
    // دریافت route اولیه از Flutter
    String initialRoute =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;

    // اگر route حاوی Deeplink ما باشد، آن را پردازش کن
    if (initialRoute.startsWith('sairon://payment-result')) {
      // ساخت Uri از route
      Uri deepLinkUri = Uri.parse(initialRoute);
      _handlePaymentResult(deepLinkUri);
    }
  }

  void _handlePaymentResult(Uri uri) {
    log('Payment result received: $uri');
    final params = uri.queryParameters;
    final status = params['status'];
    final transactionId = params['transactionId'];
    final referenceId = params['referenceId'];

    setState(() {
      _isProcessing = false;
    });

    if (_createdOrderId != null &&
        status == 'success' &&
        transactionId != null &&
        referenceId != null) {
      context.read<OrderBloc>().add(
        VerifyPayment(
          orderId: _createdOrderId!,
          transactionId: transactionId,
          referenceId: referenceId,
        ),
      );
    } else if (status == 'failed') {
      final errorMessage = params['message'] ?? 'پرداخت ناموفق بود';
      _showPaymentResultDialog(false, errorMessage);
    } else if (status == 'canceled') {
      _showPaymentResultDialog(false, 'پرداخت توسط شما لغو شد');
    } else {
      _showPaymentResultDialog(false, 'خطا در پرداخت');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = OrderBloc(OrderUseCases(repository: orderRepository));
        bloc.add(
          CalculateShipping(
            province: widget.addressEntity.province,
            city: widget.addressEntity.city,
          ),
        );
        return bloc;
      },
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderCreated) {
            // Order created successfully, now get payment token
            _createdOrderId = state.order!.id;
            _getPaymentToken(context, state.order!);
          } else if (state is PaymentTokenLoaded) {
            // Redirect to payment gateway
            _redirectToPaymentGateway(state.data!);
          } else if (state is PaymentVerified) {
            // Payment verified successfully
            _showPaymentResultDialog(true, 'پرداخت با موفقیت انجام شد');
          } else if (state is OrderError) {
            // Show error
            _showErrorDialog(context, state.message);
            setState(() {
              _isCreatingOrder = false;
              _isProcessing = false;
            });
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return ScreenLoadingIndicator();
          } else if (state is OrderError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<OrderBloc>().add(
                  CalculateShipping(
                    province: widget.addressEntity.province,
                    city: widget.addressEntity.city,
                  ),
                );
              },
            );
          } else if (state is ShippingCalculated) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: _isProcessing || _isCreatingOrder
                  ? _buildProcessingView()
                  : _buildPaymentForm(
                      context,
                      widget.addressEntity,
                      state.shipping!,
                    ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مبلغ قابل پرداخت:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            state
                                .shipping!
                                .total
                                .formattedDoublePrice
                                .withPriceLable,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.successColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        FloatingActionButton(
                          backgroundColor: AppColors.backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: Constants.primaryRadius,
                            side: BorderSide(
                              width: 2,
                              color: AppColors.successColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.successColor,
                            size: 26,
                          ),
                        ),
                        SizedBox(width: 16),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                _createOrder(context, state.shipping!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.successColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: Constants.primaryRadius,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isCreatingOrder
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'پرداخت',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_forward, size: 26),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PaymentTokenLoaded) {
            return ScreenLoadingIndicator();
          } else {
            throw 'مشکلی در بارگیری این صفحه پیش آمد ${state.toString()}';
          }
        },
      ),
    );
  }

  Widget _buildPaymentForm(
    BuildContext context,
    AddressEntity address,
    OrderPreviewEntity order,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShippingInfoCard(addressEntity: address),
          const SizedBox(height: 16),

          const ProductItemsCard(),
          const SizedBox(height: 16),

          PriceSummaryCard(
            totalAmount: order.subtotal + order.totalDiscount,
            discount: order.totalDiscount,
            shippingInfoEntity: order.shippingInfo,
            payableAmount: order.total,
          ),
          const SizedBox(height: 16),

          PaymentMethodCard(
            onMethodSelected: (method) {
              setState(() {
                _selectedMethod = method;
              });
            },
          ),
          const SizedBox(height: 24),

          const TermsAndConditions(),
        ],
      ),
    );
  }

  Widget _buildProcessingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          Text(
            _isCreatingOrder
                ? 'در حال ایجاد سفارش'
                : 'در حال انتقال به درگاه پرداخت',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'لطفاً کمی صبر کنید...',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Future<void> _createOrder(
    BuildContext context,
    OrderPreviewEntity preview,
  ) async {
    setState(() {
      _isCreatingOrder = true;
    });

    final address = widget.addressEntity;
    context.read<OrderBloc>().add(
      CreateOrder(
        firstName: address.receiver,
        lastName: ' ', // Last name is not used in backend
        phone: address.phoneNumber,
        province: address.province,
        city: address.city,
        address: address.address,
        postalCode: address.postalCode,
      ),
    );
  }

  Future<void> _getPaymentToken(BuildContext context, OrderModel order) async {
    final address = widget.addressEntity;
    context.read<OrderBloc>().add(
      GetPaymentToken(
        orderId: order.id,
        amount: order.total,
        phone: address.phoneNumber,
        redirectUrl: "sairon://payment-result",
      ),
    );
  }

  Future<void> _redirectToPaymentGateway(
    Map<String, dynamic> paymentData,
  ) async {
    // دریافت URL درگاه از بک‌اند
    final paymentUrl = paymentData['paymentUrl'];

    if (paymentUrl == null) {
      _showErrorDialog(context, 'خطا در دریافت اطلاعات درگاه پرداخت');
      return;
    }

    setState(() {
      _isCreatingOrder = false;
      _isProcessing = true;
    });

    final uri = Uri.parse(paymentUrl);

    // ✅ باز کردن درگاه در مرورگر خارجی
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // مرورگر خارجی
        webViewConfiguration: WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } else {
      setState(() {
        _isProcessing = false;
      });
      _showErrorDialog(context, 'خطا در بازکردن درگاه پرداخت');
    }
  }

  void _showPaymentResultDialog(bool isSuccess, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSuccess
                      ? AppColors.successColor.withOpacity(0.1)
                      : AppColors.errorColor.withOpacity(0.1),
                ),
                child: Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                  size: 40,
                  color: isSuccess
                      ? AppColors.successColor
                      : AppColors.errorColor,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isSuccess ? 'پرداخت موفق!' : 'خطا در پرداخت',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isSuccess
                      ? AppColors.successColor
                      : AppColors.errorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (!isSuccess)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'انصراف',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  if (!isSuccess) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (isSuccess) {
                          // Navigate to home
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        } else {
                          // Retry payment
                          setState(() {
                            _isProcessing = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(isSuccess ? 'بازگشت به خانه' : 'تلاش مجدد'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('خطا'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('باشه'),
          ),
        ],
      ),
    );
  }
}
