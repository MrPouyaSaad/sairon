import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            GradientAppBar(
              title: 'آدرس‌های من',
              gradient: GradientTheme.primaryGradient,
            ),
            Expanded(
              child: BlocConsumer<AddressBloc, AddressState>(
                listener: (context, state) {
                  // مدیریت پیام‌های موفقیت‌آمیز
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

                  // مدیریت خطاها
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
                        onAddAddress: () => _navigateToAddAddress(context),
                      );
                    } else {
                      return _buildList(state.addresses, state, context);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    List<AddressEntity> addresses,
    AddressState state,
    BuildContext context,
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
                onPressed: () => _navigateToAddAddress(context),
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

                return AddressCard(
                  address: address,
                  isLoading: isWorking,
                  onEdit: () => _editAddress(address, context),
                  onDelete: () => BlocProvider.of<AddressBloc>(
                    context,
                  ).add(RemoveAddress(addressId: address.id.toString())),
                  onSetDefault: () => BlocProvider.of<AddressBloc>(
                    context,
                  ).add(SetAsDefault(addressId: address.id.toString())),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddAddress(BuildContext context) {
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: addressBloc,
          child: const AddAddressPage(),
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
