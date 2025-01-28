
import 'package:flowery_driver/domain/entity/pending_orders/order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/repository/home/pending_orders_repo.dart';
import '../../data_source/remote_data_source/home/pending_orders_data_source.dart';

@Injectable(as: PendingOrderRepository)
class PendingOrderRepositoryImpl extends PendingOrderRepository {
  final HomeRemoteDataSource dataSource;

  PendingOrderRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<OrderEntity?>>> getPendingOrders() async {
    final response = await dataSource.getPendingOrders();
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
