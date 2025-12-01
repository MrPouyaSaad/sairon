part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CheckInitialData extends SplashEvent {
  const CheckInitialData();
}

class NavigateToHome extends SplashEvent {
  const NavigateToHome();
}

class NavigateToLogin extends SplashEvent {
  const NavigateToLogin();
}
