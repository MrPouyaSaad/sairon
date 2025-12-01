class AddressEntity {
  final int id;
  final String title;
  final String receiver;
  final String province;
  final String city;
  final String postalCode;
  final String phoneNumber;
  final String address;
  final bool isDefault;

  AddressEntity({
    required this.id,
    required this.title,
    required this.receiver,
    required this.province,
    required this.city,
    required this.postalCode,
    required this.phoneNumber,
    required this.address,
    required this.isDefault,
  });

  AddressEntity copyWith({
    int? id,
    String? title,
    String? receiver,
    String? province,
    String? city,
    String? postalCode,
    String? phoneNumber,
    String? address,
    bool? isDefault,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      receiver: receiver ?? this.receiver,
      province: province ?? this.province,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
