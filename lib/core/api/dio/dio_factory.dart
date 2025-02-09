import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../api_const.dart';
import 'token_interceptor.dart';

@injectable
class DioFactory {
  DioFactory();

  Duration get _timeout => const Duration(seconds: 60);

  @factoryMethod
  Dio createDio() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 180),
      receiveTimeout: Duration(seconds: 180),
      validateStatus: (status) =>
      status != null ? status == 200 || status == 201 : false,
    );
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = ApiConstants.baseUrl;
          return handler.next(options);
        },
      ),

      if (!kReleaseMode)
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
    ]);

    return dio;
  }

  @factoryMethod
  Dio createTokenDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      validateStatus: (status) => status != null ? status <= 500 : false,
    );

    dio.interceptors.addAll([
      TokenInterceptor(),
      if (!kReleaseMode)
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
    ]);

    return dio;
  }
}