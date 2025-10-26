import '../../../core/api/api_result.dart';
import '../../../data/model/order/UpdateOrderDetailsRequestBody.dart';
import '../../entity/order_details/update_order_entity.dart';

abstract class OrderDetailsRepository {
  Future<Result<UpdateOrdersEntity?>> updateOrderState(String orderId, UpdateOrderDetailsRequestBody state);
  Future<Result<UpdateOrdersEntity?>> startOrder(String orderId);
}
