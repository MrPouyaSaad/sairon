import 'package:sairon/features/address/domain/entities/address.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.title,
    required super.receiver,
    required super.province,
    required super.city,
    required super.postalCode,
    required super.phoneNumber,
    required super.address,
    required super.isDefault,
  });
  AddressModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] ?? 0,
        title: json['title'] ?? 'بدون عنوان',
        receiver: json['receiver'] ?? '',
        phoneNumber: json['phone'] ?? '',
        province: json['province'] ?? '',
        city: json['city'] ?? '',
        address: json['address'] ?? '',
        postalCode: json['postalCode'] ?? '',
        isDefault: json['isDefault'] ?? false,
      );
}
