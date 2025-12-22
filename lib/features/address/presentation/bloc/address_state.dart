part of 'address_bloc.dart';

enum AddressOperationStatus { idle, loading, success, error }

class AddressState extends Equatable {
  final bool isLoading;
  final List<AddressEntity> addresses;
  final AddressOperationStatus operationStatus;
  final String? operationMessage;
  final String? workingAddressId;
  final String? selectedAddressId;

  const AddressState({
    required this.isLoading,
    required this.addresses,
    required this.operationStatus,
    this.selectedAddressId,
    this.operationMessage,
    this.workingAddressId,
  });

  factory AddressState.initial() => const AddressState(
    isLoading: true,
    addresses: [],
    operationStatus: AddressOperationStatus.idle,
    operationMessage: null,
    workingAddressId: null,
  );

  AddressState copyWith({
    bool? isLoading,
    List<AddressEntity>? addresses,
    AddressOperationStatus? operationStatus,
    String? operationMessage,
    String? workingAddressId,
    final String? selectedAddressId,
  }) {
    return AddressState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,

      operationStatus: operationStatus ?? this.operationStatus,
      operationMessage: operationMessage,
      workingAddressId: workingAddressId,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    addresses,
    operationStatus,
    selectedAddressId,
    operationMessage,
    workingAddressId,
  ];
}
