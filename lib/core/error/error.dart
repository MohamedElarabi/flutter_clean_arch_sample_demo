import 'package:equatable/equatable.dart';

import '../utils/network/dio.dart';

abstract class Failure<T> extends Equatable {
  final String msg;
  final dynamic data;
  final ErrorType errorType;
  const Failure({this.msg = '', this.data, this.errorType = ErrorType.none});
  @override
  List<Object?> get props => [msg, data];
}

class ServerFailure extends Failure {
  const ServerFailure({super.msg, super.data, super.errorType});
}
