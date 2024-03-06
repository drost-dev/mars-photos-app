part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {}

class HomeScreenLoading extends HomeScreenState {
  @override
  List<Object?> get props => [];
}

class HomeScreenLoaded extends HomeScreenState {
  final Nasa data;
  final int imageIndex;
  HomeScreenLoaded({required this.data, this.imageIndex = 0});
  
  @override
  List<Object?> get props => [data, imageIndex];
}

class HomeScreenLoadError extends HomeScreenState {
  @override
  List<Object?> get props => [];
}