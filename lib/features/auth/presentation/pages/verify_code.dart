import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sairon/features/auth/presentation/widgets/background.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/gradient.dart';
import '../widgets/auth_logo.dart';
import '../widgets/code_input_field.dart';
import '../widgets/countdown_timer.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final int codeLength = 5;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  String _currentCode = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(codeLength, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
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
            const Background(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    AuthLogo(
                      title:
                          'کد تایید 5 رقمی به شماره ${widget.phoneNumber} ارسال شد.',
                    ),
                    const SizedBox(height: 40),

                    GradientCard(
                      padding: const EdgeInsets.all(24),
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          void onVerifyPressed() {
                            final code = _controllers.map((e) => e.text).join();
                            if (code.length != codeLength) {
                              Get.snackbar(
                                'خطا',
                                'کد باید $codeLength رقمی باشد',
                                icon: Icon(Iconsax.warning_2),
                                backgroundColor: AppColors.warningColor,
                                animationDuration: Duration(microseconds: 500),
                                forwardAnimationCurve: Curves.easeIn,
                              );
                              return;
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(code)) {
                              Get.snackbar(
                                'خطا',
                                'کد فقط باید شامل اعداد باشد',
                              );
                              return;
                            }
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthVerify(
                                phoneNumber: widget.phoneNumber,
                                code: code,
                              ),
                            );
                            debugPrint('کد معتبر: $code');
                          }

                          return Column(
                            children: [
                              _buildHeader(),
                              const SizedBox(height: 24),

                              CodeInputField(
                                controllers: _controllers,
                                focusNodes: _focusNodes,
                                onCodeChanged: (code) => _currentCode = code,
                              ),

                              state is AuthSendCodeLaoding
                                  ? ButtonLoadingIndicator()
                                  : _buildResendSection(
                                      state is AuthSendCodeLaoding
                                          ? () {}
                                          : () {
                                              log('Resend code ...');
                                              context.read<AuthBloc>().add(
                                                AuthSendCode(
                                                  phoneNumber:
                                                      widget.phoneNumber,
                                                ),
                                              );
                                            },
                                    ),

                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: Constants.primaryButtonHeight,
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading
                                      ? () {}
                                      : onVerifyPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.backgroundColor,
                                    foregroundColor: AppColors.primaryColor,
                                  ),
                                  child: state is AuthLoading
                                      ? ButtonLoadingIndicator()
                                      : Text('تایید و ورود'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
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
          'تایید شماره موبایل',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            wordSpacing: -1,
            color: AppColors.surfaceColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'لطفاً کد تایید دریافت شده را وارد کنید',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.surfaceColor,
            wordSpacing: -1,
          ),
        ),
      ],
    );
  }

  Widget _buildResendSection(VoidCallback onResend) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownTimer(initialSeconds: 90, onResend: onResend),

        MaxGap(500),
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'ویرایش شماره',
            style: TextStyle(
              color: AppColors.surfaceColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
