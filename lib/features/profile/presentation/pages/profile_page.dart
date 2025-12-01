import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/core/widgets/login_promt_screen.dart';
import 'package:sairon/features/address/presentation/pages/address_page.dart';
import 'package:sairon/features/auth/data/repositories/token_repo.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';
import 'package:sairon/features/order/presentation/pages/orders_page.dart';
import 'package:sairon/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sairon/features/profile/domain/usecases/profile_usecases.dart';
import 'package:sairon/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sairon/features/profile/presentation/pages/user_info_page.dart';
import 'package:sairon/features/profile/presentation/widgets/profile_header.dart';
import 'package:sairon/features/profile/presentation/widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TokenRepository.tokenNotifier,
      builder: (context, value, child) {
        if (value == null) {
          return LoginPromtScreen(
            description: 'برای مشاهده حساب کاربری ابتدا وارد شوید.',
          );
        }
        return BlocProvider(
          create: (context) =>
              ProfileBloc(ProfileUsecases(repository: profileRepository))
                ..add(ProfileStarted()),
          child: Scaffold(
            backgroundColor: Colors.grey[50],
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: ScreenLoadingIndicator());
                } else if (state is ProfileError) {
                  return AppErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<ProfileBloc>().add(ProfileStarted());
                    },
                  );
                } else if (state is ProfileLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileHeader(
                          user: state.user!,
                          onEditProfile: () {
                            Get.to(UserInfoPage(user: state.user!));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildUserInfoSection(state.user!),
                        _buildOrdersSection(),

                        _buildSupportSection(),

                        _buildLogoutSection(),

                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                } else {
                  throw 'مشکلی در بارگیری حساب کاربری پیش آمد!';
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoSection(UserEntity user) {
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
          onTap: () {
            Get.to(UserInfoPage(user: user));
          },
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
          subtitle: 'ارتباط با پشتیبانی سایرون',
          onTap: _contactSupport,
          iconColor: Colors.purple,
        ),
        ProfileMenuItem(
          icon: Icons.info_outline_rounded,
          title: 'درباره ما',
          subtitle: 'اطلاعات درباره اپلیکیشن سایرون',
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

  void _navigateToAddresses() {
    Get.to(AddressPage());
  }

  void _navigateToOrders() {
    Get.to(OrdersPage());
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
