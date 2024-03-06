part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

class LoadHomeScreen extends HomeScreenEvent {
  final int imgInd;
  final Nasa? data;
  LoadHomeScreen({this.imgInd = 0, this.data});

  @override
  List<Object?> get props => [data, imgInd];
}