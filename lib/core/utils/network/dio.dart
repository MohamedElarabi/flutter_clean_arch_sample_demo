import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../end_point_laravel.dart';
import '../logger.dart';

class DioHelper {
  final Dio _dio = Dio();
  final log = LoggerDebug();
  DioHelper() {
    _dio.interceptors.add(CustomApiInterceptor(log));
  }

  Future<CustomResponse> post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? prams}) async {
    try {
      log.cyan("------ Current Request BODY -----");
      log.cyan("$body");
      final result = await _dio.post(
        AppConstance.baseUrl + url,
        data: FormData.fromMap(body ?? {}),
        queryParameters: prams,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
      return CustomResponse(
        success: true,
        statusCode: result.statusCode ?? 200,
        errType: ErrorType.serverError,
        msg: result.data["messages"] ?? "your request sent successfly",
        data: result.data,
      );
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.serverError,
        msg: "LocaleKeys.something_went_wrong_please_try_again.tr()",
        data: {},
      );
    }
  }

  Future<CustomResponse> get(String url,
      {Map<String, dynamic>? prams, bool withHeader = true}) async {
    try {
      final result = await _dio.get(
        AppConstance.baseUrl + url,
        queryParameters: prams,
        options: Options(
          headers: withHeader
              ? {
                  "Accept": "application/json",
                }
              : null,
        ),
      );

      return CustomResponse(
        success: true,
        statusCode: result.statusCode ?? 200,
        errType: ErrorType.serverError,
        msg: result.data["messages"] ?? "your request sent successfly",
        data: result.data,
      );
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.serverError,
        msg: "LocaleKeys.something_went_wrong_please_try_again.tr()",
        data: {},
      );
    }
  }

  CustomResponse handleServerError(DioException err) {
    if (err.type == DioExceptionType.badResponse &&
        err.response?.data.toString().isNotEmpty == true) {
      if (err.response!.data.toString().contains("DOCTYPE") ||
          err.response!.data.toString().contains("<script>") ||
          err.response!.data["exception"] != null) {
        // firebaseCrashlytics.apiRecordError(
        //   err.response?.data,
        //   err.stackTrace,
        //   "${err.requestOptions.path} (${err.requestOptions.method})",
        // );
        // if (kDebugMode) FlashHelper.errorBar(message: "${err.response!.data}");
        return CustomResponse(
          success: false,
          errType: ErrorType.serverError,
          statusCode: err.response!.statusCode ?? 500,
          msg: kDebugMode
              ? "${err.response!.data}"
              : "LocaleKeys.something_went_wrong_please_try_again.tr()",
          data: err.response?.data ?? {},
        );
      }
      if (err.response?.statusCode == 401) {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 401,
          errType: ErrorType.unAuthError,
          msg: err.response?.data["message"] ?? '',
          data: err.response?.data ?? {},
        );
      }
      return CustomResponse(
        success: false,
        statusCode: err.response?.statusCode ?? 500,
        errType: ErrorType.backendVError,
        msg: err.response?.data["message"] ?? "",
        data: err.response?.data ?? {},
      );
    } else if (err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return CustomResponse(
        success: false,
        statusCode: 404,
        errType: ErrorType.networkError,
        msg:
            "LocaleKeys.poor_connection_check_the_quality_of_the_internet.tr()",
        data: {},
      );
    } else {
      if (err.response == null) {
        return CustomResponse(
          success: false,
          statusCode: 402,
          errType: ErrorType.networkError,
          msg: "LocaleKeys.please_check_your_internet_connection.tr()",
          data: {},
        );
      }
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.serverError,
        msg: "LocaleKeys.something_went_wrong_please_try_again.tr()",
        data: {},
      );
    }
  }
}

class CustomResponse {
  final bool success;
  final dynamic data;
  final ErrorType errType;
  final int statusCode;
  final String msg;

  CustomResponse(
      {required this.msg,
      required this.success,
      required this.data,
      required this.errType,
      required this.statusCode});
}

enum ErrorType { none, serverError, backendVError, networkError, unAuthError }

class CustomApiInterceptor extends Interceptor {
  final LoggerDebug log;
  CustomApiInterceptor(this.log);
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.red("\x1B[37m------ Current Error Response -----\x1B[0m");
    log.red("\x1B[31m${err.response?.data}\x1B[0m");
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log.green("------ Current Response ------");
    log.green(jsonEncode(response.data));
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.queryParameters.isNotEmpty) {
      log.cyan("------ Current Request Parameters Data -----");
      log.cyan("${options.queryParameters}");
    }
    log.yellow("------ Current Request Headers -----");
    log.yellow("${options.headers}");
    log.green("------ Current Request Path -----");
    log.green(
        "${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}");
    return super.onRequest(options, handler);
  }
}
