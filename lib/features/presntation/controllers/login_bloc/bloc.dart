import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/login_use_case.dart';
import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc(
    this.loginUseCase,
  ) : super(const LoginState()) {
    on<ClickLoginEvent>(_login);
  }
  final LoginPrams loginPrams = LoginPrams();

  Future<void> _login(ClickLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(requestState: GlobalState.isLoading));
    final result = await loginUseCase.sendDataLogin(loginPrams);
    result.fold(
      (l) =>
          emit(state.copyWith(requestState: GlobalState.isError, msg: l.msg)),
      (r) {
        emit(state.copyWith(user: r, requestState: GlobalState.isLoaded));
      },
    );
  }
}
