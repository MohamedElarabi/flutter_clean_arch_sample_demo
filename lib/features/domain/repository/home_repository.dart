import 'package:dartz/dartz.dart';
import '../../../core/error/error.dart';
import '../entities/home.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, HomeEntites>> home();
}
