import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_photos_app/models/nasa.dart';
import 'package:mars_photos_app/repos/api.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenLoading()) {
    on<LoadHomeScreen>(_load);
    on<ReloadHomeScreen>(_reload);
  }

  void _load(LoadHomeScreen event, Emitter<HomeScreenState> emit) async {
    try {
      if (state is! HomeScreenLoaded) {
        Map<String, dynamic> apiData = await getNasaData();
        Nasa nasaData = Nasa.fromJson(apiData);
        emit(HomeScreenLoaded(data: nasaData, imageIndex: 0));
      }
    } catch (e) {
      emit(HomeScreenLoadError(err: e));
    }
  }

  void _reload(ReloadHomeScreen event, Emitter<HomeScreenState> emit) async {
    try {
      if (state is HomeScreenLoaded) {
        if (event.listCamera == null) {
          //default
          emit(HomeScreenLoaded(data: event.data!, imageIndex: event.imgInd));
        } else if (event.listCamera != event.prevCamera) {
          //new cam selected
          Map<String, dynamic> apiData = await getNasaData(event.listCamera);
          Nasa nasaData = Nasa.fromJson(apiData);
          emit(HomeScreenLoaded(data: nasaData, imageIndex: 0, listCamera: event.listCamera));
        } else if (event.listCamera == event.prevCamera) {
          //selected cam is same
          emit(HomeScreenLoaded(data: event.data!, imageIndex: event.imgInd, listCamera: event.listCamera));
        }
      }
    } catch (e) {
      emit(HomeScreenLoadError(err: e));
    }
  }
}