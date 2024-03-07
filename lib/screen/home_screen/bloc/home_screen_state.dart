part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {}

class HomeScreenInitializating extends HomeScreenState {
  //init
  @override
  List<Object?> get props => [];
}

class HomeScreenLoading extends HomeScreenState {
  //loading screen data
  @override
  List<Object?> get props => [];
}

class HomeScreenLoaded extends HomeScreenState {
  //rendered screen with data
  final Nasa data;
  final int imageIndex;
  final String? listCamera;
  HomeScreenLoaded({required this.data, this.imageIndex = 0, this.listCamera});
  
  @override
  List<Object?> get props => [data, imageIndex, listCamera];
}

class HomeScreenLoadError extends HomeScreenState {
  //error state
  final dynamic err;

  HomeScreenLoadError(this.err);

  @override
  List<Object?> get props => [err];
}