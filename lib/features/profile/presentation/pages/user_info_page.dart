// lib/features/profile/presentation/pages/user_info_page.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/widgets/app_textfield.dart';
import 'package:sairon/core/widgets/gradient.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';

import '../../../../core/widgets/gradient_appbar.dart';
import '../../../auth/data/models/user.dart';

class UserInfoPage extends StatefulWidget {
  final UserEntity user;

  const UserInfoPage({super.key, required this.user});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _nationalCodeController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _nationalCodeController = TextEditingController(
      text: widget.user.nationalCode,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nationalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          GradientAppBar(
            title: 'ویرایش اطلاعات',
            showBackButton: true,
            onBackPressed: () => Navigator.of(context).pop(),
          ),

          // محتوای فرم
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // کارت فرم
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ModernTextField(
                                  controller: _firstNameController,
                                  hintText: 'نام',
                                  icon: Icons.person_outline,
                                  isRequired: true,
                                  title: 'نام',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ModernTextField(
                                  controller: _lastNameController,
                                  hintText: 'نام خانوادگی',
                                  icon: Icons.person_outlined,
                                  isRequired: true,
                                  title: 'نام خانوادگی',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          ModernTextField(
                            controller: _phoneController,
                            hintText: 'شماره موبایل',
                            icon: Icons.phone_iphone_outlined,
                            isRequired: true,
                            keyboardType: TextInputType.phone,
                            title: 'شماره موبایل',
                          ),
                          const SizedBox(height: 20),

                          ModernTextField(
                            controller: _nationalCodeController,
                            hintText: 'کد ملی',
                            icon: Icons.badge_outlined,
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            title: 'کد ملی',
                          ),
                          const SizedBox(height: 20),

                          ModernTextField(
                            controller: _emailController,
                            hintText: 'ایمیل (اختیاری)',
                            icon: Icons.email_outlined,
                            isRequired: false,
                            keyboardType: TextInputType.emailAddress,
                            title: 'ایمیل',
                          ),
                          const SizedBox(height: 30),

                          GradientButton(
                            text: 'ذخیره اطلاعات',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // اطلاعات حساب
                  _buildAccountInfoCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Iconsax.user_octagon, color: Colors.grey[600], size: 20),
                const SizedBox(width: 8),
                const Text(
                  'اطلاعات حساب',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildInfoItem('تاریخ ایجاد حساب', '۱۴۰۲/۱۰/۱۵'),
            const SizedBox(height: 12),
            _buildInfoItem('وضعیت حساب', 'فعال'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _saveUserInfo() {
    // اعتبارسنجی فیلدهای اجباری
    if (_firstNameController.text.isEmpty) {
      _showError('لطفا نام خود را وارد کنید');
      return;
    }

    if (_lastNameController.text.isEmpty) {
      _showError('لطفا نام خانوادگی خود را وارد کنید');
      return;
    }

    if (_phoneController.text.isEmpty) {
      _showError('لطفا شماره موبایل خود را وارد کنید');
      return;
    }

    if (_nationalCodeController.text.isEmpty) {
      _showError('لطفا کد ملی خود را وارد کنید');
      return;
    }

    final updatedUser = UserModel(
      id: widget.user.id,
      phoneNumber: _phoneController.text,
      nationalCode: _nationalCodeController.text,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
    );

    // TODO: Save user info to backend
    _saveChanges(updatedUser);
  }

  void _saveChanges(UserModel updatedUser) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ذخیره تغییرات'),
        content: const Text('اطلاعات کاربر با موفقیت به‌روزرسانی شد.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(updatedUser);
            },
            child: const Text('باشه'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
