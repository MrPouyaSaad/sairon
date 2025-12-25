import 'package:sairon/features/category/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['image'] ?? '',
      );
}
