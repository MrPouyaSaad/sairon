import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserEntity>> getUserInfo();
  Future<Either<Failure, void>> editUserInfo(UserEntity user);
}
