import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/auth/domain/repositories/auth_repo.dart';

class AuthUseCases {
  final AuthRepository authRepository;

  AuthUseCases({required this.authRepository});

  Future<Either<Failure, void>> sendVerifyCode(String phoneNumber) =>
      authRepository.sendVerifyCode(phoneNumber);
  Future<Either<Failure, String>> verifyCode(String phoneNumber, String code) =>
      authRepository.verifyCode(phoneNumber, code);
  Future<Either<Failure, void>> logOut() => authRepository.logOut();
}
