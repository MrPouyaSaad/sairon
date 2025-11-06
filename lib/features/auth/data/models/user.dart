import 'package:sairon/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.phoneNumber,
    required super.nationalCode,
    required super.email,
    required super.firstName,
    required super.lastName,
  });
  UserModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'],
        phoneNumber: json['phone'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        nationalCode: json['nationalCode'],
        email: json['email'],
      );
}
