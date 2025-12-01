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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  String? _validatePersianName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'لطفا $fieldName خود را وارد کنید';
    }

    final persianRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    if (!persianRegex.hasMatch(value)) {
      return '$fieldName باید فقط شامل حروف فارسی باشد';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'فرمت ایمیل نامعتبر است';
    }

    return null;
  }

  String? _validateNationalCode(String? value) {
    if (value == null || value.isEmpty) {
      return null; // کد ملی اختیاری است
    }

    if (value.length != 10) {
      return 'کد ملی باید ۱۰ رقمی باشد';
    }

    final digitRegex = RegExp(r'^\d+$');
    if (!digitRegex.hasMatch(value)) {
      return 'کد ملی باید فقط شامل اعداد باشد';
    }

    try {
      final code = value.split('').map(int.parse).toList();
      int sum = 0;

      for (int i = 0; i < 9; i++) {
        sum += code[i] * (10 - i);
      }

      int remainder = sum % 11;
      int controlDigit = code[9];

      if ((remainder < 2 && controlDigit == remainder) ||
          (remainder >= 2 && controlDigit == (11 - remainder))) {
        return null;
      } else {
        return 'کد ملی معتبر نیست';
      }
    } catch (e) {
      return 'کد ملی نامعتبر است';
    }
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

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
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
                                    validator: (value) =>
                                        _validatePersianName(value, 'نام'),
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
                                    validator: (value) => _validatePersianName(
                                      value,
                                      'نام خانوادگی',
                                    ),
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
                              enabled: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'لطفا شماره موبایل خود را وارد کنید';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            ModernTextField(
                              controller: _nationalCodeController,
                              hintText: 'کد ملی (اختیاری)',
                              icon: Icons.badge_outlined,
                              isRequired: false,
                              keyboardType: TextInputType.number,
                              title: 'کد ملی',
                              validator: _validateNationalCode,
                            ),
                            const SizedBox(height: 20),

                            ModernTextField(
                              controller: _emailController,
                              hintText: 'ایمیل (اختیاری)',
                              icon: Icons.email_outlined,
                              isRequired: false,
                              keyboardType: TextInputType.emailAddress,
                              title: 'ایمیل',
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 30),

                            GradientButton(
                              text: 'ذخیره اطلاعات',
                              onPressed: _saveUserInfo,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildAccountInfoCard(),
                  ],
                ),
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
    // اعتبارسنجی فرم
    if (!_formKey.currentState!.validate()) {
      _showError('لطفا خطاهای فرم را برطرف کنید');
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
