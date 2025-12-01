import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/address/domain/entities/address.dart';

abstract class AddressRepo {
  Future<Either<Failure, List<AddressEntity>>> getAddressList();
  Future<Either<Failure, void>> removeAddress(String id);
  Future<Either<Failure, void>> editAddressList(AddressEntity address);
  Future<Either<Failure, void>> addAddressList(AddressEntity address);
  Future<Either<Failure, void>> setDefault(String id);
}
