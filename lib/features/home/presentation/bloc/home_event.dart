part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  final int page;
  const LoadHomeData({this.page = 1});
  @override
  List<Object> get props => [page];
}
