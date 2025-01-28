import 'package:dio/dio.dart';
import 'package:flowery_driver/data/model/pending_orders/pending_orders_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
part 'home_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiManager {
  @factoryMethod
  factory HomeApiManager(Dio dio) = _HomeApiManager;
  @GET(ApiConstants.pendingOrders)
  Future<PendingOrdersResponseModel> getPendingOrders(
      @Header("Authorization") String token);
}
