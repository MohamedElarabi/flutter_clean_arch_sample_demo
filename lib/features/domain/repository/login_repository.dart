import 'package:dartz/dartz.dart';

import '../../../core/error/error.dart';
import '../entities/login.dart';
import '../usecases/login_use_case.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, Login>> login(LoginPrams prams);
}
