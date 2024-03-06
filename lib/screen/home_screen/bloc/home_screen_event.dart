part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

class LoadHomeScreen extends HomeScreenEvent {
  LoadHomeScreen();

  @override
  List<Object?> get props => [];
}

class ReloadHomeScreen extends HomeScreenEvent {
  final int imgInd;
  final Nasa? data;
  final String? listCamera;
  final String? prevCamera;
  ReloadHomeScreen({this.imgInd = 0, this.data, this.listCamera, this.prevCamera});

  @override
  List<Object?> get props => [data, imgInd, listCamera, prevCamera];
}