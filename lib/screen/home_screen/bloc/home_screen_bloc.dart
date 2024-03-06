import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_photos_app/models/nasa.dart';
import 'package:mars_photos_app/repos/api.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenLoading()) {
    on<LoadHomeScreen>(_load);
  }

  void _load(LoadHomeScreen event, Emitter<HomeScreenState> emit) async {
    try {
      if (state is! HomeScreenLoaded) {
        Map<String, dynamic> apiData = await getNasaData();
        Nasa nasaData = Nasa.fromJson(apiData);
        emit(HomeScreenLoaded(data: nasaData, imageIndex: 0));
      } else if (state is HomeScreenLoaded) {
        emit(HomeScreenLoaded(data: event.data!, imageIndex: event.imgInd));
      }
    } catch (e) {
      emit(HomeScreenLoadError());
    }
  }
}