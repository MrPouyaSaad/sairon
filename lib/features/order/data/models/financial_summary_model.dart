import 'package:sairon/features/order/domain/entities/summery_entity.dart';

class FinancialSummaryModel extends FinancialSummaryEntity {
  FinancialSummaryModel.fromJson(Map<String, dynamic> json)
    : super(
        subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
        discount: (json['discount'] as num?)?.toDouble() ?? 0,
        tax: (json['tax'] as num?)?.toDouble() ?? 0,
        shippingCost: (json['shippingCost'] as num?)?.toDouble() ?? 0,
        total: (json['total'] as num?)?.toDouble() ?? 0,
      );
}
