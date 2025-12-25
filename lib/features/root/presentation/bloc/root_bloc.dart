import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc() : super(const RootState(selectedIndex: 0)) {
    on<ChangeTab>(_onChangeTab);
    on<BackButtonPressed>(_onBackButtonPressed);
  }

  void _onChangeTab(ChangeTab event, Emitter<RootState> emit) {
    if (state.selectedIndex != event.index) {
      final updatedHistory = List<int>.from(state.history)
        ..add(state.selectedIndex);
      emit(state.copyWith(selectedIndex: event.index, history: updatedHistory));
    }
  }

  void _onBackButtonPressed(BackButtonPressed event, Emitter<RootState> emit) {
    if (state.history.isNotEmpty) {
      final updatedHistory = List<int>.from(state.history);
      final previous = updatedHistory.removeLast();
      emit(state.copyWith(selectedIndex: previous, history: updatedHistory));
      return;
    }

    if (!state.showExitWarning) {
      emit(state.copyWith(showExitWarning: true));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(showExitWarning: false));
      });
    } else {}
  }
}
