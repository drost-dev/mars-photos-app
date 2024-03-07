import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_photos_app/models/nasa.dart';
import 'package:mars_photos_app/api.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitializating()) {
    on<LoadHomeScreen>(_load);
    on<UpdateHomeScreen>(_update);
  }

  void _load(LoadHomeScreen event, Emitter<HomeScreenState> emit) async {
    //on app loading
    try {
      //api request
      emit(HomeScreenLoading());

      Map<String, dynamic> apiData = await getNasaData();
      Nasa nasaData = Nasa.fromJson(apiData);
      emit(HomeScreenLoaded(data: nasaData, imageIndex: 0));
      //changing state to loaded with api data
    } catch (e) {
      //err handling
      emit(HomeScreenLoadError(e));
    }
  }

  void _update(UpdateHomeScreen event, Emitter<HomeScreenState> emit) async {
    try {
      if (event.listCamera == null) {
        //default
        emit(HomeScreenLoaded(data: event.data!, imageIndex: event.imgInd));
      } else if (event.listCamera != event.prevCamera) {
        //new cam selected
        emit(HomeScreenLoading());
        Map<String, dynamic> apiData = await getNasaData(event.listCamera);
        Nasa nasaData = Nasa.fromJson(apiData);
        emit(HomeScreenLoaded(data: nasaData, imageIndex: 0, listCamera: event.listCamera));
      } else if (event.listCamera == event.prevCamera) {
        //selected cam is same
        emit(HomeScreenLoaded(data: event.data!, imageIndex: event.imgInd, listCamera: event.listCamera));
      }
    } catch (e) {
      emit(HomeScreenLoadError(e));
    }
  }
}