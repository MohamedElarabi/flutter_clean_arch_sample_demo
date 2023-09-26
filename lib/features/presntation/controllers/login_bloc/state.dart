import 'package:clean_arc_first/features/domain/entities/login.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';

class LoginState extends Equatable {
  final String msg;
  final GlobalState requestState;
  final Login? user;

  const LoginState(
      {this.user, this.msg = '', this.requestState = GlobalState.init});

  LoginState copyWith({String? msg, GlobalState? requestState, Login? user}) =>
      LoginState(
        msg: msg ?? this.msg,
        requestState: requestState ?? this.requestState,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [msg, requestState];
}
