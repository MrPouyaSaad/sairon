import 'package:sairon/features/order/domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id']?.toString() ?? '',
        method: json['method']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        transactionId: json['transactionId']?.toString(),
        referenceId: json['referenceId']?.toString(),
        createdAt: DateTime.parse(
          json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        ),
        paidAt: json['paidAt'] != null
            ? DateTime.parse(json['paidAt']!.toString())
            : null,
      );
}
