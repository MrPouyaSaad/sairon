// lib/features/address/presentation/pages/address_page.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sairon/core/widgets/app_textfield.dart';
import 'package:sairon/core/widgets/gradient_appbar.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
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
  final List<AddressEntity> _sampleAddresses = [
    AddressEntity(
      id: 1,
      title: 'منزل',
      receiver: 'علی محمدی',
      province: 'تهران',
      city: 'تهران',
      postalCode: '1234567890',
      phoneNumber: '09123456789',
      address: 'خیابان ولیعصر، کوچه فلان، پلاک ۱۲۳، طبقه ۲',
      isDefault: true,
    ),
    AddressEntity(
      id: 2,
      title: 'دفتر کار',
      receiver: 'علی محمدی',
      province: 'تهران',
      city: 'شهرک غرب',
      postalCode: '0987654321',
      phoneNumber: '02188776655',
      address: 'بلوار فرحزادی، خیابان ایران زمین، برج سامان، واحد ۵',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          GradientAppBar(
            title: 'آدرس‌های من',
            gradient: GradientTheme.primaryGradient,
          ),

          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_sampleAddresses.isEmpty) {
      return EmptyAddresses(onAddAddress: _addNewAddress);
    }

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
              Gap(12),
              GradientButton(
                onPressed: _addNewAddress,
                text: 'افزودن آدرس',
                shadow: false,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(Icons.add_rounded, size: 28, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: _sampleAddresses.length,
              itemBuilder: (context, index) {
                final address = _sampleAddresses[index];
                return AddressCard(
                  address: address,
                  onEdit: () => _editAddress(address),
                  onDelete: () => _deleteAddress(address),
                  onSetDefault: () => _setDefaultAddress(address),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addNewAddress() {
    // TODO: Navigate to add address page
    print('افزودن آدرس جدید');
  }

  void _editAddress(AddressEntity address) {
    // TODO: Navigate to edit address page
    print('ویرایش آدرس: ${address.title}');
  }

  void _deleteAddress(AddressEntity address) {
    // TODO: Show confirmation dialog and delete address
    print('حذف آدرس: ${address.title}');
  }

  void _setDefaultAddress(AddressEntity address) {
    // TODO: Set address as default
    print('تنظیم آدرس پیش‌فرض: ${address.title}');
  }

  void _showFilterOptions() {
    // TODO: Show filter bottom sheet
    print('نمایش فیلترها');
  }
}
