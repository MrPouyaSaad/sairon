import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/errors/exception_helper.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';
import 'package:sairon/features/profile/domain/usecases/profile_usecases.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecases usecases;
  ProfileBloc(this.usecases) : super(ProfileLoading()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileStarted) {
        final user = await usecases.getUserInfo();
        final failure = extractLeft(user);
        if (failure != null) {
          emit(ProfileError(message: failure.message));
          return;
        }
        emit(ProfileLoaded(user: extractRight(user)));
      }
      if (event is ProfileEdit) {}
    });
  }
}
