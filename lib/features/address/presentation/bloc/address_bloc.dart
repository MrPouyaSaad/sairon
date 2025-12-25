import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import 'package:sairon/features/address/domain/usecases/address_usecase.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressUsecase usecase;

  AddressBloc(this.usecase) : super(AddressState.initial()) {
    on<LoadAddressList>(_loadList);
    on<RemoveAddress>(_removeAddress);
    on<AddAddress>(_addAddress);
    on<EditAddress>(_editAddress);
    on<SetAsDefault>(_setDefault);
    on<SelectAddress>((event, emit) {
      emit(state.copyWith(selectedAddressId: event.addressId));
    });
  }

  Future<void> _loadList(
    LoadAddressList event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.getAddressList();
    final failure = extractLeft(result);

    if (failure != null) {
      emit(
        state.copyWith(
          isLoading: false,
          operationStatus: AddressOperationStatus.error,
          operationMessage: failure.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        addresses: extractRight(result),
        operationStatus: AddressOperationStatus.idle,
        operationMessage: null,
      ),
    );
  }

  Future<void> _removeAddress(
    RemoveAddress event,
    Emitter<AddressState> emit,
  ) async {
    emit(
      state.copyWith(
        operationStatus: AddressOperationStatus.loading,
        workingAddressId: event.addressId,
      ),
    );

    final res = await usecase.removeAddress(event.addressId);
    final failure = extractLeft(res);

    if (failure != null) {
      emit(
        state.copyWith(
          operationStatus: AddressOperationStatus.error,
          operationMessage: failure.message,
          workingAddressId: null,
        ),
      );
      return;
    }

    final updated = state.addresses
        .where((e) => e.id != event.addressId)
        .toList();

    emit(
      state.copyWith(
        addresses: updated,
        operationStatus: AddressOperationStatus.success,
        workingAddressId: null,
      ),
    );
  }

  Future<void> _addAddress(AddAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(operationStatus: AddressOperationStatus.loading));

    final res = await usecase.addAddressList(event.addressEntity);
    final failure = extractLeft(res);

    if (failure != null) {
      emit(
        state.copyWith(
          operationStatus: AddressOperationStatus.error,
          operationMessage: failure.message,
        ),
      );
      return;
    }

    final updated = List<AddressEntity>.from(state.addresses)
      ..add(event.addressEntity);

    emit(
      state.copyWith(
        addresses: updated,
        operationStatus: AddressOperationStatus.success,
      ),
    );
  }

  Future<void> _editAddress(
    EditAddress event,
    Emitter<AddressState> emit,
  ) async {
    emit(
      state.copyWith(
        operationStatus: AddressOperationStatus.loading,
        workingAddressId: event.addressEntity.id.toString(),
      ),
    );

    final res = await usecase.editAddressList(event.addressEntity);
    final failure = extractLeft(res);

    if (failure != null) {
      emit(
        state.copyWith(
          operationStatus: AddressOperationStatus.error,
          operationMessage: failure.message,
          workingAddressId: null,
        ),
      );
      return;
    }

    final updated = state.addresses.map((e) {
      if (e.id == event.addressEntity.id) return event.addressEntity;
      return e;
    }).toList();

    emit(
      state.copyWith(
        addresses: updated,
        operationStatus: AddressOperationStatus.success,
        workingAddressId: null,
      ),
    );
  }

  Future<void> _setDefault(
    SetAsDefault event,
    Emitter<AddressState> emit,
  ) async {
    emit(
      state.copyWith(
        operationStatus: AddressOperationStatus.loading,
        workingAddressId: event.addressId,
      ),
    );

    final res = await usecase.setDefault(event.addressId);
    final failure = extractLeft(res);

    if (failure != null) {
      emit(
        state.copyWith(
          operationStatus: AddressOperationStatus.error,
          operationMessage: failure.message,
          workingAddressId: null,
        ),
      );
      return;
    }

    final updated = state.addresses.map((e) {
      return e.copyWith(isDefault: e.id == int.parse(event.addressId));
    }).toList();

    emit(
      state.copyWith(
        addresses: updated,
        operationStatus: AddressOperationStatus.success,
        workingAddressId: null,
      ),
    );
  }
}
