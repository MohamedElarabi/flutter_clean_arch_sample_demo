import 'package:clean_arc_first/features/data/datasources/auth_remote_datasources.dart';
import 'package:clean_arc_first/features/domain/entities/login.dart';
import 'package:clean_arc_first/features/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/error.dart';
import '../../../core/utils/network/error_message.dart';
import '../../domain/usecases/login_use_case.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  AuthRepository(this.baseAuthRemoteDataSource);

  @override
  Future<Either<Failure, Login>> login(LoginPrams prams) async {
    try {
      final result = await baseAuthRemoteDataSource.login(prams);
      return Right(result);
    } on ErrorMessageModel catch (e) {
      return Left(ServerFailure(msg: e.message));
    }
  }
}
