import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/order_details/update_order_entity.dart';
import '../../repository/order_details/order_details_repository.dart';

@injectable
class StartOrderUseCase {
  final OrderDetailsRepository _repository;
  StartOrderUseCase(this._repository);
  Future<Result<UpdateOrdersEntity?>> call(String orderId) async {
    final result = await _repository.startOrder(orderId);
    return result;
  }
}
