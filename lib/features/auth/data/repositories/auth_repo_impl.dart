import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sairon/features/auth/domain/repositories/auth_repo.dart';

import 'token_repo.dart';

final dataSource = AuthRemoteDataSourceImpl(
  httpClient: ApiConstants.httpClient,
);
final authRepository = AuthRepositoryImpl(dataSource: dataSource);

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  static final ValueNotifier<String?> authNotifier = ValueNotifier(null);

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> sendVerifyCode(String phoneNumber) async {
    return safeCall(() => dataSource.sendVerifyCode(phoneNumber));
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    final result = await safeCall(() => dataSource.clearToken());
    result.fold((failure) => null, (_) => TokenRepository.currentToken = null);
    return result;
  }

  @override
  Future<Either<Failure, String>> verifyCode(
    String phoneNumber,
    String code,
  ) async {
    final result = await safeCall(
      () => dataSource.verifyCode(phoneNumber, code),
    );
    result.fold(
      (failure) => null,
      (token) => TokenRepository.currentToken = token,
    );
    return result;
  }
}
