import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../api_const.dart';
import 'token_interceptor.dart';

class DioFactory {
  DioFactory();

  Duration get _timeout => const Duration(seconds: 60);

  Dio createDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      validateStatus: (status) {
        // Allow both successful responses and 4xx errors to be handled by the app
        return status != null && status < 500;
      },
    );
    addFreeDioInterceptors(dio);
    return dio;
  }

  Dio createTokenDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      validateStatus: (status) => status != null && status < 500,
    );
    addTokenDioInterceptors(dio);
    return dio;
  }

  void addFreeDioInterceptors(Dio dio) {
    dio.interceptors.addAll([
      if (!kReleaseMode)
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
    ]);
  }

  void addTokenDioInterceptors(Dio dio) {
    dio.interceptors.addAll([
      TokenInterceptor(),
      if (!kReleaseMode)
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
    ]);
  }
}