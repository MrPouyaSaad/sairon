import 'package:sairon/features/slider/domain/entities/slider_entity.dart';

class SliderModel extends SliderEntity {
  SliderModel.fromJson(Map<String, dynamic> json)
    : super(imageUrl: json['image'] as String);
}
