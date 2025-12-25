import '../../domain/entities/shipping_info.dart';

class ShippingInfoModel extends ShippingInfoEntity {
  ShippingInfoModel.fromJson(Map<String, dynamic> json)
    : super(
        method: json['method'] ?? '',
        cost: json['cost'] ?? 0,
        freeShippingThreshold: json['freeShippingThreshold'] ?? 0,
        isFree: json['isFree'] ?? false,
        message: json['message'] ?? '',
      );
}
