import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  // Remove the dioFactory registration and directly create Dio
  @lazySingleton
  Dio get dio => Dio()
    ..options = BaseOptions(
      baseUrl: 'https://flower.elevateegy.com/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      validateStatus: (status) =>
      status != null ? status == 200 || status == 201 : false,
    );
}