import '../../../../core/api/api_result.dart';
import '../../../model/pending_orders/order_model.dart';

abstract class HomeRemoteDataSource {
  Future<Result<List<OrderModel?>>> getPendingOrders();
}
