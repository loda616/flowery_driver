import 'package:flowery_driver/domain/entity/drivers_order/order_entity.dart';
import '../../../core/api/api_result.dart';

abstract class DriverOrdersRepository {
  Future<Result<List<OrderEntity?>>> getDriverOrders();
}