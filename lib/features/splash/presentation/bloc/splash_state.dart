part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {
  final int cartItemsCount;
  final bool isUserLoggedIn;

  const SplashSuccess({
    required this.cartItemsCount,
    required this.isUserLoggedIn,
  });

  @override
  List<Object> get props => [cartItemsCount, isUserLoggedIn];
}

class SplashError extends SplashState {
  final String message;

  const SplashError({required this.message});

  @override
  List<Object> get props => [message];
}
