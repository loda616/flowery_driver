import '../../../core/api/api_result.dart';
import '../../entity/pending_orders/order_entity.dart';

abstract class PendingOrderRepository {

  Future<Result<List<OrderEntity?>>> getPendingOrders();

}

