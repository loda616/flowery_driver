import 'package:injectable/injectable.dart';
import '../../repository/order_details/order_details_repository.dart';

@injectable
class UpdateOrderStateUseCase {
  final OrderDetailsRepository _repository;

  UpdateOrderStateUseCase(this._repository);

  Future<void> call(String orderId, String state) async {
    await _repository.updateOrderState(orderId, state);
  }
}
