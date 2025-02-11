import 'package:flowery_driver/domain/entity/drivers_order/order_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../repository/driver_orders/driver_orders_repository.dart';

@injectable
class GetDriverOrdersUseCase {
  final DriverOrdersRepository repository;

  GetDriverOrdersUseCase({required this.repository});

  Future<Result<List<OrderEntity?>>> invoke() async {
    return await repository.getDriverOrders();
  }
}