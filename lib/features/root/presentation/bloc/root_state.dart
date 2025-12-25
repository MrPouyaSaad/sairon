part of 'root_bloc.dart';

class RootState extends Equatable {
  final int selectedIndex;
  final List<int> history;
  final bool showExitWarning;

  const RootState({
    required this.selectedIndex,
    this.history = const [],
    this.showExitWarning = false,
  });

  RootState copyWith({
    int? selectedIndex,
    List<int>? history,
    bool? showExitWarning,
  }) {
    return RootState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      history: history ?? this.history,
      showExitWarning: showExitWarning ?? this.showExitWarning,
    );
  }

  @override
  List<Object> get props => [selectedIndex, history, showExitWarning];
}
