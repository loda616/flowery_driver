import 'package:dio/dio.dart';
import 'package:flowery_driver/data/model/order/update_order_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_const.dart';
import '../../model/order/UpdateOrderDetailsRequestBody.dart';
part 'order_details_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class OrderDetailsApiManager {
  @factoryMethod
  factory OrderDetailsApiManager(Dio dio) = _OrderDetailsApiManager;
  @PUT("${ApiConstants.updateOrderDetails}/{orderId}")
  Future<UpdateOrderResponseModel?> updateOrderState(
      @Path('orderId') String orderId,
      @Body() UpdateOrderDetailsRequestBody state,
      @Header("Authorization") String token);

  @PUT("${ApiConstants.startOrder}/{orderId}")
  Future<UpdateOrderResponseModel?> startOrder(
      @Path('orderId') String orderId,
      @Header("Authorization") String token);
}
