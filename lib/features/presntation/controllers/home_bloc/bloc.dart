import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/home_use_case.dart';
import 'event.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;
  HomeBloc(
    this.homeUseCase,
  ) : super(const HomeState()) {
    on<ClickHomeEvent>(_home);
  }

  Future<void> _home(ClickHomeEvent event, Emitter<HomeState> emit) async {
    print("${state.requestState}_________________________");
    emit(state.copyWith(requestState: GlobalState.isLoading));
    // print("${state.requestState}_________________________");

    final result = await homeUseCase.home();
    result.fold(
      (l) =>
          emit(state.copyWith(requestState: GlobalState.isError, msg: l.msg)),
      (r) {
        emit(
            state.copyWith(homeEntites: r, requestState: GlobalState.isLoaded));
      },
    );
    // print("${state.requestState}_________________________");
  }
}
