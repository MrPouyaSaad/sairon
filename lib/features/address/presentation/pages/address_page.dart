import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/app_textfield.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/gradient_appbar.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/address/data/repositories/address_repo_impl.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import 'package:sairon/features/address/domain/usecases/address_usecase.dart';
import 'package:sairon/features/address/presentation/bloc/address_bloc.dart';
import 'package:sairon/features/address/presentation/pages/add_address.dart';
import 'package:sairon/features/address/presentation/widgets/address_card.dart';

import '../../../../core/widgets/gradient.dart';
import '../widgets/empty_address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({this.isCheckout = false, super.key});
  final bool isCheckout;
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController controller = TextEditingController();
  String? _selectedAddressId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressBloc(AddressUsecase(repository: addressRepository))
            ..add(LoadAddressList()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Column(
          children: [
            if (!widget.isCheckout)
              GradientAppBar(
                title: 'آدرس‌های من',
                gradient: GradientTheme.primaryGradient,
              ),
            Expanded(
              child: BlocConsumer<AddressBloc, AddressState>(
                listener: (context, state) {
                  if (state.operationStatus == AddressOperationStatus.success) {
                    if (state.operationMessage?.isNotEmpty == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.operationMessage!),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }

                  if (state.operationStatus == AddressOperationStatus.error) {
                    if (state.operationMessage?.isNotEmpty == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.operationMessage!),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }

                  if (state.addresses.isNotEmpty &&
                      _selectedAddressId == null) {
                    final defaultAddress = state.addresses.firstWhere(
                      (address) => address.isDefault,
                      orElse: () => state.addresses.first,
                    );
                    _selectedAddressId = defaultAddress.id.toString();
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return ScreenLoadingIndicator();
                  } else if (state.operationStatus ==
                      AddressOperationStatus.error) {
                    return AppErrorWidget(
                      message: state.operationMessage!,
                      onRetry: () {
                        BlocProvider.of<AddressBloc>(
                          context,
                        ).add(LoadAddressList());
                      },
                    );
                  } else {
                    if (state.addresses.isEmpty) {
                      return EmptyAddresses(
                        onAddAddress: () =>
                            _navigateToAddAddress(context, widget.isCheckout),
                      );
                    } else {
                      return _buildList(
                        state.addresses,
                        state,
                        context,
                        widget.isCheckout,
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !widget.isCheckout
            ? null
            : BlocBuilder<AddressBloc, AddressState>(
                buildWhen: (previous, current) =>
                    previous.addresses != current.addresses,
                builder: (context, state) {
                  AddressEntity? selectedAddress;

                  if (_selectedAddressId != null) {
                    selectedAddress = state.addresses.firstWhere(
                      (address) => address.id.toString() == _selectedAddressId,
                      orElse: () => state.addresses.firstWhere(
                        (address) => address.isDefault,
                        orElse: () => state.addresses.first,
                      ),
                    );
                  } else if (state.addresses.isNotEmpty) {
                    selectedAddress = state.addresses.firstWhere(
                      (address) => address.isDefault,
                      orElse: () => state.addresses.first,
                    );
                  }

                  return Row(
                    children: [
                      FloatingActionButton(
                        backgroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: Constants.primaryRadius,
                          side: BorderSide(
                            width: 2,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.primaryColor,
                          size: 26,
                        ),
                      ),
                      Gap(16),
                      Expanded(
                        child: FloatingActionButton(
                          onPressed: selectedAddress == null
                              ? () {
                                  log('Selected address is null');
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      message: 'لطفاً یک آدرس را انتخاب کنید',
                                      duration: Duration(seconds: 2),
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.red,
                                      borderRadius: 10,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 14,
                                      ),
                                    ),
                                  );
                                }
                              : () {
                                  log(
                                    'Selected address: ${selectedAddress?.id}',
                                  );
                                  Navigator.of(context).pushNamed(
                                    '/payment',
                                    arguments: selectedAddress,
                                  );
                                },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ادامه خرید',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Icon(Icons.arrow_forward, size: 26),
                            ],
                          ).paddingSymmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ).marginSymmetric(horizontal: 16);
                },
              ),
      ),
    );
  }

  Widget _buildList(
    List<AddressEntity> addresses,
    AddressState state,
    BuildContext context,
    bool isCheckout,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ModernTextField(
                  controller: controller,
                  hintText: 'جستجو در آدرس‌ها...',
                  icon: Icons.search,
                  isRequired: false,
                ),
              ),
              const Gap(12),
              GradientButton(
                onPressed: () => _navigateToAddAddress(context, isCheckout),
                text: 'افزودن آدرس',
                shadow: false,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                final isWorking = state.workingAddressId != null
                    ? int.parse(state.workingAddressId!) == address.id &&
                          state.operationStatus ==
                              AddressOperationStatus.loading
                    : false;

                return GestureDetector(
                  onTap: () {
                    if (isCheckout) {
                      setState(() {
                        _selectedAddressId = address.id.toString();
                      });
                      context.read<AddressBloc>().add(
                        SelectAddress(address.id.toString()),
                      );
                    }
                  },
                  child: BlocBuilder<AddressBloc, AddressState>(
                    buildWhen: (previous, current) =>
                        previous.selectedAddressId != current.selectedAddressId,
                    builder: (context, state) {
                      final isSelected =
                          _selectedAddressId == address.id.toString();

                      return AddressCard(
                        address: address,
                        isLoading: isWorking,
                        isCheckout: isCheckout,
                        isSelected: widget.isCheckout ? isSelected : false,
                        onEdit: () => _editAddress(address, context),
                        onDelete: () => context.read<AddressBloc>().add(
                          RemoveAddress(addressId: address.id.toString()),
                        ),
                        onSetDefault: () => context.read<AddressBloc>().add(
                          SetAsDefault(addressId: address.id.toString()),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddAddress(BuildContext context, bool isCheckout) {
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: addressBloc,
          child: AddAddressPage(isCheckout: isCheckout),
        ),
      ),
    );
  }

  void _editAddress(AddressEntity address, BuildContext context) {
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: addressBloc,
          child: AddAddressPage(addressEntity: address),
        ),
      ),
    );
  }
}
