class UserEntity {
  final int id;
  final String phoneNumber;
  final String? nationalCode;
  final String email;
  final String firstName;
  final String lastName;

  UserEntity({
    required this.id,
    required this.phoneNumber,
    required this.nationalCode,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
}
