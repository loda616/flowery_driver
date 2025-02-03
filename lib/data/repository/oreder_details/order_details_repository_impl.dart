import 'package:injectable/injectable.dart';
import '../../../domain/repository/order_details/order_details_repository.dart';
import '../../data_source/remote_data_source/order_details/order_details_remote_data_source.dart';

@Injectable(as: OrderDetailsRepository)
class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsRemoteDataSource _remoteDataSource;

  OrderDetailsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> updateOrderState(String orderId, String state) async {
    await _remoteDataSource.updateOrderState(orderId, state);
  }

  @override
  Future<void> startOrder(String orderId) async {
    await _remoteDataSource.startOrder(orderId);
  }
}