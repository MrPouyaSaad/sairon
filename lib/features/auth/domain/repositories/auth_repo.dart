import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendVerifyCode(String phoneNumber);
  Future<Either<Failure, String>> verifyCode(String phoneNumber, String code);
  Future<Either<Failure, void>> logOut();
}
