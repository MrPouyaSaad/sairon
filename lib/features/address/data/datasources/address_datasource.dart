import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/address/domain/entities/address.dart';

abstract class AddressDataSource {
  Future<List<AddressEntity>> getAddresses();
  Future<void> editAddress(AddressEntity address);
  Future<void> addAddress(AddressEntity address);
  Future<void> removeAddress(AddressEntity address);
  Future<void> setDefaultAddress(int addressId);
}

class AddressDataSourceImpl implements AddressDataSource {
  final Dio httpClient;

  AddressDataSourceImpl({required this.httpClient});

  @override
  Future<void> addAddress(AddressEntity address) async {
    await httpClient.post(
      AppRoutes.profile.addresses,
      data: {
        "title": address.title,
        "receiver": address.receiver,
        "phone": address.phoneNumber,
        "province": address.province,
        "city": address.city,
        "address": address.address,
        "postalCode": address.postalCode,
        "isDefault": address.isDefault,
      },
    );
  }

  @override
  Future<void> editAddress(AddressEntity address) async {
    await httpClient.put(
      '${AppRoutes.profile.addresses}/${address.id}',
      data: {
        "title": address.title,
        "receiver": address.receiver,
        "phone": address.phoneNumber,
        "province": address.province,
        "city": address.city,
        "address": address.address,
        "postalCode": address.postalCode,
        "isDefault": address.isDefault,
      },
    );
  }

  @override
  Future<List<AddressEntity>> getAddresses() async {
    final response = await httpClient.get(AppRoutes.profile.addresses);

    final List<dynamic> data = response.data['data'];
    return data
        .map(
          (json) => AddressEntity(
            id: json['id'],
            title: json['title'],
            receiver: json['receiver'],
            phoneNumber: json['phone'],
            province: json['province'],
            city: json['city'],
            address: json['address'],
            postalCode: json['postalCode'],
            isDefault: json['isDefault'],
          ),
        )
        .toList();
  }

  @override
  Future<void> removeAddress(AddressEntity address) async {
    await httpClient.delete('${AppRoutes.profile.addresses}/${address.id}');
  }

  @override
  Future<void> setDefaultAddress(int addressId) async {
    await httpClient.patch(
      AppRoutes.profile.setDefaultAddress(addressId.toString()),
    );
  }
}
