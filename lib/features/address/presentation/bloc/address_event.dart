part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

final class LoadAddressList extends AddressEvent {}

final class RemoveAddress extends AddressEvent {
  final String addressId;

  const RemoveAddress({required this.addressId});
  @override
  List<Object> get props => [addressId];
}

final class AddAddress extends AddressEvent {
  final AddressEntity addressEntity;

  const AddAddress({required this.addressEntity});

  @override
  List<Object> get props => [addressEntity];
}

final class SetAsDefault extends AddressEvent {
  final String addressId;

  const SetAsDefault({required this.addressId});
  @override
  List<Object> get props => [addressId];
}

final class EditAddress extends AddressEvent {
  final AddressEntity addressEntity;

  const EditAddress({required this.addressEntity});

  @override
  List<Object> get props => [addressEntity];
}

class SelectAddress extends AddressEvent {
  final String addressId;

  const SelectAddress(this.addressId);

  @override
  List<Object> get props => [addressId];
}
