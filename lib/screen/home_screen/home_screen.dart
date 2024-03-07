import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_photos_app/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:mars_photos_app/widgets/reloadable_error_msg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeScreenBloc = HomeScreenBloc();

  @override
  void initState() {
    _homeScreenBloc.add(LoadHomeScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Mars Photos'),
        ),
        body: BlocBuilder(
          bloc: _homeScreenBloc,
          builder: (context, state) {
            if (state is HomeScreenLoading) {
              //loading state
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeScreenLoaded) {
              //loaded state
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    state.data.photos![state.imageIndex].imgSrc!,
                    errorBuilder: (context, error, stackTrace) {
                      return ReloadableErrorMessage(
                        reloadFunc: () {
                          _homeScreenBloc.add(LoadHomeScreen());
                        },
                        errorMsg:
                            "Error while loading photo!\nProbably some troubles with your network connection.\n${error.toString()}",
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        DropdownButton(
                          hint: const Text('Choose camera'),
                          items: const [
                            DropdownMenuItem(
                              value: "CHEMCAM",
                              child: Text("Chemistry and Camera Complex"),
                            ),
                            DropdownMenuItem(
                              value: "NAVCAM",
                              child: Text("Navigation Camera"),
                            ),
                            DropdownMenuItem(
                              value: "FHAZ",
                              child: Text("Front Hazard Avoidance Camera"),
                            ),
                          ],
                          value: state.listCamera,
                          onChanged: (value) {
                            _homeScreenBloc.add(UpdateHomeScreen(
                              data: state.data,
                              imgInd: state.imageIndex,
                              listCamera: value!,
                              prevCamera: state.listCamera,
                            ));
                          },
                        ),
                        Text("""
Rover Name: ${state.data.photos![state.imageIndex].rover!.name},
Camera Name: ${state.data.photos![state.imageIndex].camera!.fullName},
Sol: ${state.data.photos![state.imageIndex].sol}
№${state.imageIndex + 1} of ${state.data.photos!.length}"""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: state.imageIndex > 0
                                  ? () => {
                                        _homeScreenBloc.add(UpdateHomeScreen(
                                          imgInd: state.imageIndex - 1,
                                          data: state.data,
                                          listCamera: state.listCamera,
                                          prevCamera: state.listCamera,
                                        ))
                                      }
                                  : null,
                              icon: const Icon(Icons.navigate_before),
                            ),
                            IconButton(
                              onPressed: state.imageIndex <
                                      state.data.photos!.length - 1
                                  ? () => {
                                        _homeScreenBloc.add(UpdateHomeScreen(
                                          imgInd: state.imageIndex + 1,
                                          data: state.data,
                                          listCamera: state.listCamera,
                                          prevCamera: state.listCamera,
                                        ))
                                      }
                                  : null,
                              icon: const Icon(Icons.navigate_next),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is HomeScreenLoadError) {
              // error state
              return Center(
                child: ReloadableErrorMessage(
                  reloadFunc: () {
                    _homeScreenBloc.add(LoadHomeScreen());
                  },
                  errorMsg:
                      "Error while loading photos!\nProbably can't get data from NASA (try to check your network connection)\n${state.err.toString()}",
                ),
              );
            } else {
              return const Center(
                child: Text("Init/Unknown state"),
              );
            }
          },
        ),
      );
    } catch (e) {
      return Center(
        child: Text(e.toString()),
      );
    }
  }
}
