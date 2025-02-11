import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/use_case/driver_orders/get_driver_orders_use_case.dart';
import 'driver_orders_state.dart';

@injectable
class DriverOrdersCubit extends BaseViewModel<DriverOrdersState> {
  final GetDriverOrdersUseCase _getDriverOrdersUseCase;

  DriverOrdersCubit(this._getDriverOrdersUseCase)
      : super(DriverOrdersInitial());

  Future<void> getDriverOrders() async {
    emit(DriverOrdersLoading());
    final result = await _getDriverOrdersUseCase.invoke();

    switch (result) {
      case Success():
        emit(DriverOrdersSuccess(result.data ?? []));
      case Fail():
        emit(DriverOrdersError(
            getErrorMassageFromException(result.exception)
        ));
    }
  }
}