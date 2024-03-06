import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_photos_app/screen/home_screen/bloc/home_screen_bloc.dart';

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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeScreenLoaded) {
              try {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      state.data.photos![state.imageIndex].imgSrc!,
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
                              _homeScreenBloc.add(ReloadHomeScreen(
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
                          /*TextField(
                        onSubmitted: (text) {
                          _homeScreenBloc.add(LoadHomeScreen(
                              imgInd: int.parse(text) - 1, data: state.data));
                        },
                        keyboardType: TextInputType.number,
                        maxLength: state.data.photos!.lastIndexOf(state.data.photos!.last).toString().length,
                      ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: state.imageIndex > 0
                                    ? () => {
                                          _homeScreenBloc.add(ReloadHomeScreen(
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
                                          _homeScreenBloc.add(ReloadHomeScreen(
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
              } catch (e) {
                return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Error while loading photos!\n${e.toString()}"),
                    TextButton(
                      onPressed: () {
                        _homeScreenBloc.add(LoadHomeScreen());
                      },
                      child: const Text('Reload...'),
                    )
                  ],
                ),
              );
              }
            } else if (state is HomeScreenLoadError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Error while loading photos!\n${state.err.toString()}"),
                    TextButton(
                      onPressed: () {
                        _homeScreenBloc.add(LoadHomeScreen());
                      },
                      child: const Text('Reload...'),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error!"),
                    TextButton(
                      onPressed: () {
                        _homeScreenBloc.add(LoadHomeScreen());
                      },
                      child: const Text('Reload...'),
                    )
                  ],
                ),
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
