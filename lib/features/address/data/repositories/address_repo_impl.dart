import 'package:dartz/dartz.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/address/data/datasources/address_datasource.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import 'package:sairon/features/address/domain/repositories/address_repo.dart';

final _datasource = AddressDataSourceImpl(httpClient: ApiConstants.httpClient);
final addressRepository = AddressRepoImpl(dataSource: _datasource);

class AddressRepoImpl implements AddressRepo {
  final AddressDataSourceImpl dataSource;

  AddressRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> addAddressList(AddressEntity address) =>
      safeCall(() => dataSource.addAddress(address));

  @override
  Future<Either<Failure, void>> editAddressList(AddressEntity address) =>
      safeCall(() => dataSource.editAddress(address));

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddressList() =>
      safeCall(() => dataSource.getAddresses());
  @override
  Future<Either<Failure, void>> removeAddress(String id) =>
      safeCall(() => dataSource.removeAddress(id));

  @override
  Future<Either<Failure, void>> setDefault(String id) =>
      safeCall(() => dataSource.setDefaultAddress(id));
}
