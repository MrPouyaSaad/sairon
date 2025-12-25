import 'package:sairon/features/order/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  InvoiceModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id']?.toString() ?? '',
        invoiceNumber: json['invoiceNumber']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        issueDate: DateTime.parse(
          json['issueDate']?.toString() ?? DateTime.now().toIso8601String(),
        ),
        subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
        discount: (json['discount'] as num?)?.toDouble() ?? 0,
        tax: (json['tax'] as num?)?.toDouble() ?? 0,
        shippingCost: (json['shippingCost'] as num?)?.toDouble() ?? 0,
        total: (json['total'] as num?)?.toDouble() ?? 0,
        items: (json['items'] as List<dynamic>? ?? [])
            .map((item) => InvoiceItemModel.fromJson(item))
            .toList(),
      );
}

class InvoiceItemModel extends InvoiceItemEntity {
  InvoiceItemModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        quantity: (json['quantity'] as num?)?.toInt() ?? 0,
        unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
        total: (json['total'] as num?)?.toDouble() ?? 0,
      );
}
