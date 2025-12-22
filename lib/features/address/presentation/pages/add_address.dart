// add_address_page.dart (اصلاح شده)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sairon/core/widgets/app_textfield.dart';
import 'package:sairon/core/widgets/gradient.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import 'package:sairon/features/address/presentation/bloc/address_bloc.dart';
import 'package:sairon/features/address/presentation/widgets/province_city_selector.dart';

import '../../../../core/widgets/gradient_appbar.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({
    super.key,
    this.addressEntity,
    this.isCheckout = false,
  });
  final AddressEntity? addressEntity;
  final bool isCheckout;
  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCity;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    if (widget.addressEntity != null) {
      _fillFormWithExistingData();
    }
  }

  void _fillFormWithExistingData() {
    final address = widget.addressEntity!;
    _receiverController.text = address.receiver;
    _phoneController.text = address.phoneNumber;
    _postalCodeController.text = address.postalCode;
    _addressController.text = address.address;
    _titleController.text = address.title;
    _selectedProvince = address.province;
    _selectedCity = address.city;
    _isDefault = address.isDefault;
  }

  void _onProvinceChanged(String province) {
    setState(() {
      _selectedProvince = province;
    });
  }

  void _onCityChanged(String city) {
    setState(() {
      _selectedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceVariant.withOpacity(0.95),
      body: Column(
        children: [
          if (!widget.isCheckout)
            GradientAppBar(
              title: widget.addressEntity == null ? 'آدرس جدید' : 'ویرایش آدرس',
              actions: widget.addressEntity != null
                  ? [_buildDeleteButton(colors)]
                  : null,
            ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ModernTextField(
                                  controller: _titleController,
                                  hintText: 'عنوان آدرس',
                                  icon: Icons.home_work_outlined,
                                  isRequired: true,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ModernTextField(
                                  controller: _receiverController,
                                  hintText: 'نام گیرنده',
                                  icon: Icons.person_outline,
                                  isRequired: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: ModernTextField(
                                  controller: _phoneController,
                                  hintText: 'شماره تماس',
                                  icon: Icons.phone_iphone_outlined,
                                  isRequired: true,
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ModernTextField(
                                  controller: _postalCodeController,
                                  hintText: 'کد پستی',
                                  icon: Icons.qr_code_outlined,
                                  isRequired: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          ProvinceCitySelector(
                            onProvinceChanged: _onProvinceChanged,
                            onCityChanged: _onCityChanged,
                            selectedProvince: _selectedProvince,
                            selectedCity: _selectedCity,
                          ),
                          const SizedBox(height: 20),

                          _buildModernAddressField(),
                          const SizedBox(height: 20),

                          _buildModernSwitch(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  BlocListener<AddressBloc, AddressState>(
                    listenWhen: (prev, curr) =>
                        prev.operationStatus != curr.operationStatus,
                    listener: (context, state) {
                      if (state.operationStatus ==
                          AddressOperationStatus.success) {
                        Get.snackbar(
                          "✅ موفقیت",
                          "آدرس با موفقیت ذخیره شد",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Color(0xFF10B981),
                          colorText: Colors.white,
                          borderRadius: 16,
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          duration: Duration(seconds: 3),
                          animationDuration: Duration(milliseconds: 500),
                          titleText: Text(
                            "موفقیت",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Yekan',
                            ),
                          ),
                          messageText: Text(
                            "آدرس با موفقیت ذخیره شد",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontFamily: 'Yekan',
                            ),
                          ),
                          boxShadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                          snackStyle: SnackStyle.FLOATING,
                        );
                        Navigator.of(context).pop();
                      }

                      if (state.operationStatus ==
                          AddressOperationStatus.error) {
                        Get.snackbar(
                          "خطا",
                          state.operationMessage ?? "مشکلی رخ داد",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        final isLoading =
                            state.operationStatus ==
                            AddressOperationStatus.loading;
                        return GradientButton(
                          onPressed: () {
                            if (widget.addressEntity != null) {
                              BlocProvider.of<AddressBloc>(context).add(
                                EditAddress(
                                  addressEntity: AddressEntity(
                                    id: widget.addressEntity!.id,
                                    title: _titleController.text,
                                    receiver: _receiverController.text,
                                    province: _selectedProvince!,
                                    city: _selectedCity!,
                                    postalCode: _postalCodeController.text,
                                    phoneNumber: _phoneController.text,
                                    address: _addressController.text,
                                    isDefault: _isDefault,
                                  ),
                                ),
                              );
                            } else {
                              BlocProvider.of<AddressBloc>(context).add(
                                AddAddress(
                                  addressEntity: AddressEntity(
                                    id: 1,
                                    title: _titleController.text,
                                    receiver: _receiverController.text,
                                    province: _selectedProvince!,
                                    city: _selectedCity!,
                                    postalCode: _postalCodeController.text,
                                    phoneNumber: _phoneController.text,
                                    address: _addressController.text,
                                    isDefault: _isDefault,
                                  ),
                                ),
                              );
                            }
                          },

                          text: isLoading ? 'درحال ذخیره ...' : 'ذخیره آدرس',
                        );
                      },
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 16, vertical: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(ColorScheme colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.delete_outline, color: colors.error),
        onPressed: () {},
      ),
    );
  }

  Widget _buildModernAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'آدرس کامل',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _addressController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: 'آدرس کامل پستی را وارد کنید...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernSwitch() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: _isDefault
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isDefault
              ? Theme.of(context).primaryColor.withOpacity(0.3)
              : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.star_rounded,
              color: _isDefault ? Colors.amber : Colors.grey[400],
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              'آدرس پیش فرض',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Transform.scale(
              scale: 1.2,
              child: Switch(
                value: _isDefault,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
