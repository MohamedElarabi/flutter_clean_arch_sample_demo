import 'dart:io';

import 'package:clean_arc_first/features/domain/entities/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/error/error.dart';
import '../repository/login_repository.dart';

class LoginUseCase {
  final BaseAuthRepository baseAuthRepository;
  LoginUseCase(this.baseAuthRepository);
  Future<Either<Failure, Login>> sendDataLogin(LoginPrams loginPrams) async {
    return await baseAuthRepository.login(loginPrams);
  }
}

class LoginPrams {
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<Map<String, dynamic>> get body async => {
        "phone_code": "20",
        "phone": phone.text,
        "password": password.text,
        "device_token": "Device Token",
        "type": Platform.operatingSystem,
      };
}
