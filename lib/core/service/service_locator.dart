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
    //UseCases
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    //Network
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
    //Repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl()));
    //Bloc    
    sl.registerFactory<LoginBloc>(() => LoginBloc(
          sl(),
        ));
  }
}
