import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../entity/pending_orders/order_entity.dart';
import '../../repository/home/pending_orders_repo.dart';

@injectable
class GetPendingOrderUseCase {
  final PendingOrderRepository orderRepository;
  GetPendingOrderUseCase({required this.orderRepository});

  Future<Result<List<OrderEntity?>>> invoke() async {
    final result = await orderRepository.getPendingOrders();
    return result;
  }
}
