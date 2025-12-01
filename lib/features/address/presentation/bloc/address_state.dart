part of 'address_bloc.dart';

enum AddressOperationStatus { idle, loading, success, error }

class AddressState extends Equatable {
  final bool isLoading; // فقط برای لود اولیه لیست
  final List<AddressEntity> addresses;
  final AddressOperationStatus operationStatus;
  final String? operationMessage; // برای خطا یا موفقیت
  final String? workingAddressId; // برای remove / setDefault / edit

  const AddressState({
    required this.isLoading,
    required this.addresses,
    required this.operationStatus,
    this.operationMessage,
    this.workingAddressId,
  });

  /// حالت اولیه
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
  }) {
    return AddressState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
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
    operationMessage,
    workingAddressId,
  ];
}
