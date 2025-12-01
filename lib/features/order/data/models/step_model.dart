import 'package:sairon/features/order/domain/entities/step_entity.dart';

class OrderStepModel extends OrderStepEntity {
  OrderStepModel.fromJson(Map<String, dynamic> json)
    : super(
        name: json['name']?.toString() ?? '',
        status: json['status']?.toString() ?? 'pending',
        date: json['date'] != null
            ? DateTime.parse(json['date']!.toString())
            : null,
      );
}
