import 'package:dartz/dartz.dart';
import 'package:sairon/features/address/domain/repositories/address_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/address.dart';

class AddressUsecase {
  final AddressRepo repository;

  AddressUsecase({required this.repository});

  Future<Either<Failure, List<AddressEntity>>> getAddressList() =>
      repository.getAddressList();
  Future<Either<Failure, void>> removeAddress(String id) =>
      repository.removeAddress(id);
  Future<Either<Failure, void>> editAddressList(AddressEntity address) =>
      repository.editAddressList(address);
  Future<Either<Failure, void>> addAddressList(AddressEntity address) =>
      repository.addAddressList(address);
  Future<Either<Failure, void>> setDefault(String id) =>
      repository.setDefault(id);
}
