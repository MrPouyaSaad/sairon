part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileLoaded extends ProfileState {
  final UserEntity? user;

  const ProfileLoaded({required this.user});
}

class ProfileEditLoading extends ProfileState {}

class ProfileEditError extends ProfileState {
  final String message;

  const ProfileEditError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileEditSuccess extends ProfileState {}
