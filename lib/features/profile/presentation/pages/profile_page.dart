import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sairon/features/address/presentation/pages/address_page.dart';
import 'package:sairon/features/profile/presentation/pages/user_info_page.dart';
import 'package:sairon/features/profile/presentation/widgets/profile_header.dart';
import 'package:sairon/features/profile/presentation/widgets/profile_menu_item.dart';

import '../../../auth/data/models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = UserModel(
      id: 1,
      phoneNumber: '09123456789',
      nationalCode: '1234567890',
      email: 'user@example.com',
      firstName: 'علی',
      lastName: 'محمدی',
    );
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(user: currentUser, onEditProfile: _editProfile),

            const SizedBox(height: 16),

            _buildUserInfoSection(),
            _buildOrdersSection(),

            _buildSupportSection(),

            _buildLogoutSection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Text(
            'اطلاعات کاربری',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        ProfileMenuItem(
          icon: Icons.person_outline_rounded,
          title: 'ویرایش اطلاعات',
          subtitle: 'تغییر نام، ایمیل و اطلاعات شخصی',
          onTap: _editProfile,
          iconColor: Colors.blue,
        ),
        ProfileMenuItem(
          icon: Icons.location_on_outlined,
          title: 'آدرس‌های من',
          subtitle: 'مدیریت آدرس‌های تحویل',
          onTap: _navigateToAddresses,
          iconColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            'سفارشات',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        ProfileMenuItem(
          icon: Icons.shopping_bag_outlined,
          title: 'سفارش‌های من',
          subtitle: 'مشاهده تاریخچه سفارشات',
          onTap: _navigateToOrders,
          iconColor: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            'پشتیبانی',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        ProfileMenuItem(
          icon: Icons.support_agent_outlined,
          title: 'پشتیبانی',
          subtitle: 'ارتباط با پشتیبانی سیرون',
          onTap: _contactSupport,
          iconColor: Colors.purple,
        ),
        ProfileMenuItem(
          icon: Icons.info_outline_rounded,
          title: 'درباره ما',
          subtitle: 'اطلاعات درباره اپلیکیشن سیرون',
          onTap: _aboutUs,
          iconColor: Colors.teal,
        ),
      ],
    );
  }

  Widget _buildLogoutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            'حساب کاربری',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.red.withOpacity(0.2), width: 1),
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.logout_rounded, color: Colors.red, size: 20),
            ),
            title: const Text(
              'خروج از حساب کاربری',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            onTap: _logout,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }

  void _editProfile() {
    Get.to(
      UserInfoPage(
        user: UserModel(
          id: 1,
          phoneNumber: '09123456789',
          nationalCode: '1234567890',
          email: 'user@example.com',
          firstName: 'علی',
          lastName: 'محمدی',
        ),
      ),
    );
  }

  void _navigateToAddresses() {
    Get.to(AddressPage());
  }

  void _navigateToOrders() {
    // TODO: Navigate to orders page
    print('صفحه سفارش‌ها');
  }

  void _contactSupport() {
    // TODO: Contact support
    print('پشتیبانی');
  }

  void _aboutUs() {
    // TODO: Show about us dialog
    print('درباره ما');
  }

  void _logout() {
    // TODO: Show logout confirmation and logout
    print('خروج از حساب کاربری');
  }
}
