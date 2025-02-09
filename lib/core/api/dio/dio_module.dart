import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_const.dart';
import 'dio_factory.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final dioFactory = DioFactory();
    return dioFactory.createDio();
  }
}
