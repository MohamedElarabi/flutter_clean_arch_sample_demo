import 'package:clean_arc_first/features/domain/entities/home.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';

class HomeState extends Equatable {
  final String msg;
  final GlobalState requestState;
  final HomeEntites? homeEntites;

  const HomeState(
      {this.homeEntites, this.msg = '', this.requestState = GlobalState.init});

  HomeState copyWith(
          {String? msg, GlobalState? requestState, HomeEntites? homeEntites}) =>
      HomeState(
        msg: msg ?? this.msg,
        requestState: requestState ?? this.requestState,
        homeEntites: homeEntites ?? this.homeEntites,
      );

  @override
  List<Object?> get props => [msg, requestState];
}
