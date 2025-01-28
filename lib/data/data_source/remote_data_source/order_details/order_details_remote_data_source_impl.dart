import 'package:injectable/injectable.dart';
import '../../../api/order_details/order_details_api_manager.dart';
import 'order_details_remote_data_source.dart';

@Injectable(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  final OrderDetailsApiManager _apiManager;

  OrderDetailsRemoteDataSourceImpl(this._apiManager);

  @override
  Future<void> updateOrderState(String orderId, String state) async {
    await _apiManager.updateOrderState(orderId, {'state': state});
  }

  @override
  Future<void> startOrder(String orderId) async {
    await _apiManager.startOrder(orderId);
  }
}