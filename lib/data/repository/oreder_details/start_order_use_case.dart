import 'package:injectable/injectable.dart';
import '../../../domain/repository/order_details/order_details_repository.dart';

@injectable
class StartOrderUseCase {
  final OrderDetailsRepository _repository;

  StartOrderUseCase(this._repository);

  Future<void> call(String orderId) async {
    await _repository.startOrder(orderId);
  }
}