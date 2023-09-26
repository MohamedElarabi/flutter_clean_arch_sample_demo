import 'package:clean_arc_first/core/service/service_locator.dart';
import 'package:clean_arc_first/features/presntation/controllers/home_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../controllers/home_bloc/event.dart';
import '../../controllers/home_bloc/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = sl<HomeBloc>();
  @override
  void initState() {
    bloc.add(ClickHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.requestState == GlobalState.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.requestState == GlobalState.isLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
                  itemCount: state.homeEntites!.vehicles.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.homeEntites!.vehicles[index].name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image(
                            fit: BoxFit.contain,
                            frameBuilder: (_, image, loadingBuilder, __) {
                              if (loadingBuilder == null) {
                                return const SizedBox(
                                  height: 300,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return image;
                            },
                            loadingBuilder: (BuildContext context, Widget image,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return image;
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) => Image.asset(
                                  "",
                                  height: 300,
                                  fit: BoxFit.fitHeight,
                                ),
                            image: NetworkImage(state
                                .homeEntites!.vehicles[index].previewImage)),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(state.msg),
                );
              }
            }));
  }
}
