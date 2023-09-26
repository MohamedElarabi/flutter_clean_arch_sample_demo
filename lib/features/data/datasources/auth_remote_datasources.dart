import 'dart:io';

import 'package:clean_arc_first/features/data/models/login_model.dart';
import 'package:dartz/dartz.dart';

// import '../../../core/utils/end_point_laravel.dart';
import '../../../core/error/error.dart';
import '../../../core/utils/end_point_laravel.dart';
import '../../../core/utils/network/dio.dart';
import '../../../core/utils/network/error_message.dart';
import '../../domain/usecases/login_use_case.dart';

abstract class BaseAuthRemoteDataSource {
  final DioHelper dioHelper;

  BaseAuthRemoteDataSource(this.dioHelper);

  Future<UserModel> login(LoginPrams prams);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  AuthRemoteDataSource(super.dioHelper);

  @override
  Future<UserModel> login(LoginPrams prams) async {
    final result = await dioHelper.post(AppConstance.loginEndPoint,
        body: await prams.body);
    if (result.success) {
      return UserModel.fromJson(result.data["data"]);
    } else {
      throw ErrorMessageModel(result.msg, result.errType);
    }
  }
}
