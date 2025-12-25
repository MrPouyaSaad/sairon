import 'package:sairon/features/address/data/models/address.dart';
import 'package:sairon/features/cart/data/model/shipping_info_model.dart';
import 'package:sairon/features/order/domain/entities/order_entity.dart';

import 'financial_summary_model.dart';
import 'invoice_model.dart';
import 'order_item_model.dart';
import 'payment_model.dart';
import 'step_model.dart';

class OrderModel extends OrderEntity {
  OrderModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id']?.toString() ?? '',
        orderNumber:
            json['orderNumber']?.toString() ?? json['id']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        statusText: json['statusText']?.toString() ?? '',
        subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
        discount: (json['discount'] as num?)?.toDouble() ?? 0,
        tax: (json['tax'] as num?)?.toDouble() ?? 0,
        shippingCost: (json['shippingCost'] as num?)?.toDouble() ?? 0,
        total: (json['total'] as num?)?.toDouble() ?? 0,
        paymentMethod: json['paymentMethod']?.toString() ?? '',
        paymentStatus: json['paymentStatus']?.toString() ?? '',
        shippingMethod: json['shippingMethod']?.toString() ?? '',
        deliveryTime: json['deliveryTime']?.toString(),
        trackingCode: json['trackingCode']?.toString(),
        createdAt: DateTime.parse(
          json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        ),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt']!.toString())
            : null,
        paidAt: json['paidAt'] != null
            ? DateTime.parse(json['paidAt']!.toString())
            : null,
        processingAt: json['processingAt'] != null
            ? DateTime.parse(json['processingAt']!.toString())
            : null,
        preparingAt: json['preparingAt'] != null
            ? DateTime.parse(json['preparingAt']!.toString())
            : null,
        shippedAt: json['shippedAt'] != null
            ? DateTime.parse(json['shippedAt']!.toString())
            : null,
        deliveredAt: json['deliveredAt'] != null
            ? DateTime.parse(json['deliveredAt']!.toString())
            : null,
        items: (json['items'] as List<dynamic>? ?? [])
            .map((item) => OrderItemModel.fromJson(item))
            .toList(),
        address: json['address'] != null
            ? AddressModel.fromJson(json['address'])
            : null,
        payments: (json['payments'] as List<dynamic>? ?? [])
            .map((payment) => PaymentModel.fromJson(payment))
            .toList(),
        invoice: json['invoice'] != null
            ? InvoiceModel.fromJson(json['invoice'])
            : null,
        steps: (json['steps'] as List<dynamic>? ?? [])
            .map((step) => OrderStepModel.fromJson(step))
            .toList(),
        shippingInfo: json['shippingInfo'] != null
            ? ShippingInfoModel.fromJson(json['shippingInfo'])
            : null,
        financialSummary: json['financialSummary'] != null
            ? FinancialSummaryModel.fromJson(json['financialSummary'])
            : null,
      );
}
