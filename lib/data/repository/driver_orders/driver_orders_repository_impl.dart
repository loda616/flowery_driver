import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../domain/entity/drivers_order/order_entity.dart';
import '../../../domain/repository/driver_orders/driver_orders_repository.dart';
import '../../data_source/remote_data_source/driver_orders/driver_orders_data_source.dart';

@Injectable(as: DriverOrdersRepository)
class DriverOrdersRepositoryImpl extends DriverOrdersRepository {
  final DriverOrdersRemoteDataSource dataSource;

  DriverOrdersRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<OrderEntity?>>> getDriverOrders() async {
    final response = await dataSource.getDriverOrders();
    switch (response) {
      case Success():
        final entities =
            response.data?.map((model) => model?.toEntity()).toList();
        return Success(data: entities);
      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
