import 'package:sairon/features/product/domain/entities/attributes.dart';

class ProductAttributeModel extends ProductAttributeEntity {
  ProductAttributeModel({
    required super.id,
    required super.name,
    required super.type,
    required super.value,
  });
  ProductAttributeModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] as int,
        name: json['name'] as String,
        value: json['value'] as String,
        type: json['type'] as String,
      );
}
