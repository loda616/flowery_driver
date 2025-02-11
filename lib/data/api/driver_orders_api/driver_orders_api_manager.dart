import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../model/driver_orders/driver_orders_response_model.dart';

part 'driver_orders_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DriverOrdersApiManager {
  @factoryMethod
  factory DriverOrdersApiManager(Dio dio) = _DriverOrdersApiManager;

  @GET(ApiConstants.getAllDriverOrders)
  Future<DriverOrdersResponseModel> getDriverOrders(
      @Header("Authorization") String token);
}