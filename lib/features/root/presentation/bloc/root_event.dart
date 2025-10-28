part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends RootEvent {
  final int index;
  const ChangeTab(this.index);

  @override
  List<Object> get props => [index];
}

class BackButtonPressed extends RootEvent {
  const BackButtonPressed();
}
