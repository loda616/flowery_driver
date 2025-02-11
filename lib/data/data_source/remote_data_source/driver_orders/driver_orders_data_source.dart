import '../../../../../../core/api/api_result.dart';
import '../../../model/driver_orders/driver_order_model.dart';

abstract class DriverOrdersRemoteDataSource {
  Future<Result<List<DriverOrderModel?>>> getDriverOrders();
}