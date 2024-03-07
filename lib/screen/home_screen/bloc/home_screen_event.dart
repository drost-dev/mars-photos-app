part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

class LoadHomeScreen extends HomeScreenEvent {
  //first loading, no settings selected
  LoadHomeScreen();

  @override
  List<Object?> get props => [];
}

class UpdateHomeScreen extends HomeScreenEvent {
  //updated settings / switched picture
  final int imgInd;
  final Nasa? data;
  final String? listCamera;
  final String? prevCamera;
  UpdateHomeScreen({this.imgInd = 0, this.data, this.listCamera, this.prevCamera});

  @override
  List<Object?> get props => [data, imgInd, listCamera, prevCamera];
}