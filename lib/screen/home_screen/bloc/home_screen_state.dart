part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {}

class HomeScreenLoading extends HomeScreenState {
  @override
  List<Object?> get props => [];
}

class HomeScreenLoaded extends HomeScreenState {
  final Nasa data;
  final int imageIndex;
  final String? listCamera;
  HomeScreenLoaded({required this.data, this.imageIndex = 0, this.listCamera});
  
  @override
  List<Object?> get props => [data, imageIndex, listCamera];
}

class HomeScreenLoadError extends HomeScreenState {
  final dynamic err;

  HomeScreenLoadError({this.err});

  @override
  List<Object?> get props => [err];
}