import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';
import 'package:sairon/features/profile/domain/repositories/profile_repo.dart';

class ProfileUsecases {
  final ProfileRepo repository;

  ProfileUsecases({required this.repository});

  Future<Either<Failure, UserEntity>> getUserInfo() => repository.getUserInfo();
  Future<Either<Failure, void>> editUserInfo(UserEntity user) =>
      repository.editUserInfo(user);
}
