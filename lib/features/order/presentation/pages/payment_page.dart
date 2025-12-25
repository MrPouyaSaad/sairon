import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import 'package:sairon/features/order/data/models/order_model.dart';
import 'package:sairon/features/order/domain/entities/order_preview_entity.dart';
import 'package:sairon/features/order/domain/usecases/order_usecases.dart';
import 'package:sairon/features/order/presentation/bloc/order_bloc.dart';

import '../../data/repositories/order_repo_impl.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/payment_webview_page.dart';
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

  String? createdOrderId;
  PaymentMethod selectedMethod = PaymentMethod.sepr;

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleInitialRoute());
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  // ================= Deeplink =================

  void _initDeepLinks() {
    _sub = _appLinks.uriLinkStream.listen(
      (uri) {
        if (uri == null) return;
        if (uri.scheme == 'sairon' && uri.host == 'payment-result') {
          _onPaymentDeeplink(uri);
        }
      },
      onError: (e) {
        log('❌ DeepLink stream error: $e');
      },
    );
  }

  void _handleInitialRoute() {
    final initialRoute =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;
    if (initialRoute.startsWith('sairon://payment-result')) {
      _onPaymentDeeplink(Uri.parse(initialRoute));
    }
  }

  void _onPaymentDeeplink(Uri uri) {
    log('🔗 Deeplink received: $uri');

    final orderId = uri.queryParameters['orderId'];
    if (orderId == null || orderId.isEmpty) {
      _showResult(false, 'شناسه سفارش نامعتبر است');
      return;
    }

    context.read<OrderBloc>().add(CheckPaymentStatus(orderId));
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
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
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, OrderState state) {
    log('🎧 State: ${state.runtimeType}');

    if (state is OrderCreated) {
      createdOrderId = state.order!.id;
      _openGatewayForOrder(state.order!, context); // ✅ مستقیم به درگاه
    } else if (state is PaymentChecking) {
      setState(() => _isProcessing = true);
    } else if (state is PaymentSuccess) {
      _resetLoading();
      _showResult(true, 'پرداخت با موفقیت انجام شد');
    } else if (state is PaymentFailed) {
      _resetLoading();
      _showResult(false, 'پرداخت ناموفق بود');
    } else if (state is OrderError) {
      _resetLoading();
      _showError(state.message);
    }
  }

  Widget _builder(BuildContext context, OrderState state) {
    if (state is OrderLoading) {
      return const ScreenLoadingIndicator();
    }

    if (state is OrderError) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: AppErrorWidget(
          message: state.message,
          onRetry: () {
            context.read<OrderBloc>().add(
              CalculateShipping(
                province: widget.addressEntity.province,
                city: widget.addressEntity.city,
              ),
            );
          },
        ),
      );
    }

    if (state is ShippingCalculated) {
      return _buildMainView(state.shipping!);
    }

    return const ScreenLoadingIndicator();
  }

  Widget _buildMainView(OrderPreviewEntity preview) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _isProcessing || _isCreatingOrder
          ? _buildProcessing()
          : _buildForm(preview),
      bottomNavigationBar: Builder(
        builder: (blocContext) => _buildBottomBar(blocContext, preview),
      ),
    );
  }

  Widget _buildForm(OrderPreviewEntity order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShippingInfoCard(addressEntity: widget.addressEntity),
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
          PaymentMethodCard(onMethodSelected: (m) => selectedMethod = m),
          const SizedBox(height: 24),
          const TermsAndConditions(),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext blocContext, OrderPreviewEntity preview) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _createOrder(preview, blocContext),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.successColor,
                shape: RoundedRectangleBorder(
                  borderRadius: Constants.primaryRadius,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'پرداخت',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessing() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('در حال انتقال به درگاه پرداخت...'),
        ],
      ),
    );
  }

  // ================= Logic =================

  void _createOrder(OrderPreviewEntity preview, BuildContext blocContext) {
    if (_isCreatingOrder) return;

    setState(() => _isCreatingOrder = true);

    final a = widget.addressEntity;
    BlocProvider.of<OrderBloc>(blocContext).add(
      CreateOrder(
        firstName: a.receiver,
        lastName: '-',
        phone: a.phoneNumber,
        province: a.province,
        city: a.city,
        address: a.address,
        postalCode: a.postalCode,
      ),
    );
  }

  Future<void> _openGatewayForOrder(
    OrderModel order,
    BuildContext blocContext,
  ) async {
    setState(() {
      _isProcessing = true;
      _isCreatingOrder = false;
    });

    final redirectUrl =
        '${ApiConstants.baseUrl}/api/payments/redirect/${order.id}';
    log('🌐 Opening gateway redirect URL in WebView: $redirectUrl');

    final uri = await Navigator.push<Uri?>(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentWebViewPage(initialUrl: redirectUrl),
      ),
    );

    if (uri != null && uri.scheme == 'sairon' && uri.host == 'payment-result') {
      _onPaymentDeeplink(uri);
      return;
    }

    BlocProvider.of<OrderBloc>(blocContext).add(CheckPaymentStatus(order.id));
  }

  // ================= Helpers =================

  void _resetLoading() {
    setState(() {
      _isProcessing = false;
      _isCreatingOrder = false;
    });
  }

  void _showResult(bool success, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(success ? 'موفق' : 'ناموفق'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (success) {
                Navigator.popUntil(context, (r) => r.isFirst);
              }
            },
            child: const Text('باشه'),
          ),
        ],
      ),
    );
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('خطا'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('باشه'),
          ),
        ],
      ),
    );
  }
}
