import 'package:dartz/dartz.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';
import 'package:sairon/features/profile/data/datasources/profile_datasource.dart';
import 'package:sairon/features/profile/domain/repositories/profile_repo.dart';

final dataSource = ProfileDataSource(httpClient: ApiConstants.httpClient);
final profileRepository = ProfileRepositoryImpl(dataSource: dataSource);

class ProfileRepositoryImpl implements ProfileRepo {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> editUserInfo(UserEntity user) =>
      safeCall(() => dataSource.editUserInfo(user));

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() =>
      safeCall(() => dataSource.getUserInfo());
}
