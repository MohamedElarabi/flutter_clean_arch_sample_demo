import 'package:clean_arc_first/features/domain/entities/home.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/error.dart';
import '../../../core/utils/network/error_message.dart';
import '../../domain/repository/home_repository.dart';
import '../datasources/home_datasources.dart';

class HomeRepository extends BaseHomeRepository {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;
  HomeRepository(this.baseHomeRemoteDataSource);

  @override
  Future<Either<Failure, HomeEntites>> home() async {
    try {
      final result = await baseHomeRemoteDataSource.home();
      return Right(result);
    } on ErrorMessageModel catch (e) {
      return Left(ServerFailure(msg: e.message));
    }
  }
}
