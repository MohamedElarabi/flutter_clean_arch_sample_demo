import 'package:equatable/equatable.dart';

import 'dio.dart';

class ErrorMessageModel extends Equatable {
  final String message;
  final ErrorType errorType;
  final dynamic data;

  const ErrorMessageModel(this.message, this.errorType, [this.data]);

  @override
  List<Object?> get props => [message, errorType];
}
