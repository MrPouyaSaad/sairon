import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sairon/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:sairon/features/auth/domain/usecases/usecases.dart';
import 'package:sairon/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../root/presentation/pages/root.dart';
import 'send_code.dart';
import 'verify_code.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthUseCases(authRepository: authRepository)),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSentCode) {
            Get.to(
              () => BlocProvider.value(
                value: context.read<AuthBloc>(),
                child: VerifyCode(phoneNumber: state.phoneNumber),
              ),
            );
          } else if (state is AuthVerified) {
            final args = Get.arguments as Map<String, dynamic>?;
            final returnTo = args?['returnTo'];

            if (returnTo != null && returnTo is String && returnTo.isNotEmpty) {
              Get.offNamed(returnTo);
            } else {
              Get.off(() => RootScreen());
            }
          } else if (state is AuthSendCodeError || state is AuthVerifyError) {
            final msg = (state is AuthSendCodeError)
                ? state.message
                : (state as AuthVerifyError).message;
            Get.snackbar('خطا', msg);
          }
        },
        child: const SendCodeScreen(),
      ),
    );
  }
}
