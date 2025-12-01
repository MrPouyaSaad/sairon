part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileStarted extends ProfileEvent {}

final class ProfileEdit extends ProfileEvent {
  final UserEntity user;

  const ProfileEdit({required this.user});
  @override
  List<Object> get props => [user];
}
