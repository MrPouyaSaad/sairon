import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sairon/features/auth/presentation/widgets/background.dart';
import '../../../../core/widgets/gradient.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_footer.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({super.key});

  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
  String _phone = '';
  String? _errorText;
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onPhoneChanged(String phone) {
    setState(() {
      _phone = phone;
      _errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF5F3FF), Color(0xFFEEF2FF)],
          ),
        ),
        child: Stack(
          children: [
            Background(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const AuthLogo(),
                    const SizedBox(height: 40),
                    GradientCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 24),

                          PhoneNumberField(
                            onChanged: _onPhoneChanged,
                            errorText: _errorText,
                          ),

                          const SizedBox(height: 24),

                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                height: Constants.primaryButtonHeight,
                                child: ElevatedButton(
                                  onPressed: state is AuthSendCodeLaoding
                                      ? () {}
                                      : () {
                                          if (_phone.isEmpty) {
                                            setState(() {
                                              _errorText =
                                                  'شماره موبایل معتبر نیست';
                                            });
                                            return;
                                          }
                                          context.read<AuthBloc>().add(
                                            AuthSendCode(phoneNumber: _phone),
                                          );
                                          log('📱 ارسال به سرور: $_phone');
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.backgroundColor,
                                    foregroundColor: AppColors.primaryColor,
                                  ),
                                  child: state is AuthSendCodeLaoding
                                      ? ButtonLoadingIndicator()
                                      : Text('دریافت کد تأیید'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const AuthFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'ورود به ســایـرون',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            wordSpacing: -1,
            color: AppColors.surfaceColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'لطفاً شماره موبایل خود را وارد کنید',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.surfaceColor,
            wordSpacing: -1,
          ),
        ),
      ],
    );
  }
}
