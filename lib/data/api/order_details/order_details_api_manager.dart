import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'order_details_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: "https://flower.elevateegy.com/api/v1/")  // Add the complete base URL
abstract class OrderDetailsApiManager {
  @factoryMethod
  factory OrderDetailsApiManager(Dio dio) = _OrderDetailsApiManager;

  @PUT('orders/state/{orderId}')
  Future<void> updateOrderState(
      @Path('orderId') String orderId,
      @Body() Map<String, String> state,
      );

  @PUT('orders/start/{orderId}')
  Future<void> startOrder(@Path('orderId') String orderId);
}