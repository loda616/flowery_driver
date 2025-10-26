import 'package:flowery_driver/core/api/api_result.dart';
import 'package:flowery_driver/domain/entity/order_details/update_order_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../data/model/order/UpdateOrderDetailsRequestBody.dart';
import '../../repository/order_details/order_details_repository.dart';

@injectable
class UpdateOrderStateUseCase {
  final OrderDetailsRepository _repository;

  UpdateOrderStateUseCase(this._repository);

  Future<Result<UpdateOrdersEntity?>> call(String orderId,UpdateOrderDetailsRequestBody state) async {
   final result= await _repository.updateOrderState(orderId, state);
   return result;
  }
}
