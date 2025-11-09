part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSendCodeLaoding extends AuthState {}

class AuthSentCode extends AuthState {
  final String phoneNumber;

  const AuthSentCode({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class AuthSendCodeError extends AuthState {
  final String message;

  const AuthSendCodeError({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthVerified extends AuthState {}

class AuthVerifyError extends AuthState {
  final String message;

  const AuthVerifyError({required this.message});
  @override
  List<Object> get props => [message];
}
