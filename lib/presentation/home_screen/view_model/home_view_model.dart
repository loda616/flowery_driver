import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/entity/pending_orders/order_entity.dart';
import '../../../domain/use_case/home/pending_orders_use_case.dart';
import 'home_states.dart';

@injectable
class HomeCubit extends BaseViewModel<HomeState> {
  GetPendingOrderUseCase orderUseCase;
  HomeCubit(
    this.orderUseCase,
  ) : super(PendingOrderInitialState());
  OrderEntity? orderEntity;

  Future<void> getPendingOrders() async {
    emit(PendingOrderLoadingState());
    var result = await orderUseCase.invoke();
    switch (result) {
      case Success():
        emit(PendingGetOrdersSuccessState(orders: result.data ?? []));
      case Fail():
        emit(PendingGetOrdersErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}
