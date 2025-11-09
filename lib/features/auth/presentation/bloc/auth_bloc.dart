import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/auth/domain/usecases/usecases.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases useCases;
  AuthBloc(this.useCases) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthSendCode) {
        emit(AuthSendCodeLaoding());
        final res = await useCases.sendVerifyCode(event.phoneNumber);
        final failure = extractLeft(res);
        if (failure != null) {
          emit(AuthSendCodeError(message: failure.message));
          return;
        }
        emit(AuthSentCode(phoneNumber: event.phoneNumber));
      } else if (event is AuthVerify) {
        emit(AuthLoading());
        final res = await useCases.verifyCode(event.phoneNumber, event.code);
        final failure = extractLeft(res);
        if (failure != null) {
          emit(AuthVerifyError(message: failure.message));
          return;
        }
        emit(AuthVerified());
      }
    });
  }
}
