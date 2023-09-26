import 'package:clean_arc_first/features/domain/entities/home.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/error.dart';
import '../repository/home_repository.dart';

class HomeUseCase {
  final BaseHomeRepository baseHomeRepository;
  HomeUseCase(this.baseHomeRepository);
  Future<Either<Failure, HomeEntites>> home() async {
    return await baseHomeRepository.home();
  }
}
