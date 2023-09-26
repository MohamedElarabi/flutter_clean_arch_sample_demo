import 'package:clean_arc_first/features/data/datasources/auth_remote_datasources.dart';
import 'package:clean_arc_first/features/domain/repository/login_repository.dart';
import 'package:clean_arc_first/features/domain/usecases/login_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../features/data/datasources/home_datasources.dart';
import '../../features/data/repository/base_auth_repository.dart';
import '../../features/data/repository/base_home_repository.dart';
import '../../features/domain/repository/home_repository.dart';
import '../../features/domain/usecases/home_use_case.dart';
import '../../features/presntation/controllers/home_bloc/bloc.dart';
import '../../features/presntation/controllers/login_bloc/bloc.dart';
import '../utils/network/dio.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    //UseCases
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => HomeUseCase(sl()));
    //Network
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
    //Repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl()));
    sl.registerLazySingleton<BaseHomeRepository>(() => HomeRepository(sl()));
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSource(sl()));
    //Bloc
    sl.registerFactory<LoginBloc>(() => LoginBloc(
          sl(),
        ));
    sl.registerFactory<HomeBloc>(() => HomeBloc(
          sl(),
        ));
  }
}
