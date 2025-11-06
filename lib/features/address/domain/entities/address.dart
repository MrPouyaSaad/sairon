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
}
