import '../../../../core/api/api_result.dart';
import '../../../model/order/UpdateOrderDetailsRequestBody.dart';
import '../../../model/order/update_order_model.dart';

abstract class OrderDetailsRemoteDataSource {
  Future<Result<UpdateOrdersModel?>> updateOrderState( String orderId, UpdateOrderDetailsRequestBody state);
  Future<Result<UpdateOrdersModel?>> startOrder( String orderId);
}