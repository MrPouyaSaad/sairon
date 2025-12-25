part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthSendCode extends AuthEvent {
  final String phoneNumber;

  const AuthSendCode({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

final class AuthVerify extends AuthEvent {
  final String phoneNumber;
  final String code;

  const AuthVerify({required this.phoneNumber, required this.code});

  @override
  List<Object> get props => [phoneNumber, code];
}
