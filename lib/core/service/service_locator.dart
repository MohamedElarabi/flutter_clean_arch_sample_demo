import 'package:clean_arc_first/features/data/datasources/auth_remote_datasources.dart';
import 'package:clean_arc_first/features/domain/repository/login_repository.dart';
import 'package:clean_arc_first/features/domain/usecases/login_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../features/data/repository/base_auth_repository.dart';
import '../../features/presntation/controllers/login_bloc/bloc.dart';

import '../utils/network/dio.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl()));
    sl.registerFactory<LoginBloc>(() => LoginBloc(
          sl(),
        ));
    ////// Bloc
  }
}
