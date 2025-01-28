import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../data/repository/oreder_details/start_order_use_case.dart';
import '../../../domain/use_case/order_details/update_order_state_use_case.dart';
import '../widget/order_status_indicator.dart';
import 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final UpdateOrderStateUseCase _updateOrderStateUseCase;
  final StartOrderUseCase _startOrderUseCase;

  OrderDetailsCubit(
      this._updateOrderStateUseCase,
      this._startOrderUseCase,
      ) : super(OrderDetailsInitial());

  OrderStatus currentStatus = OrderStatus.accepted;

  String getButtonText() {
    switch (currentStatus) {
      case OrderStatus.accepted:
        return "Arrived at Pickup Point";
      case OrderStatus.picked:
        return "Start Deliver";
      case OrderStatus.outForDelivery:
        return "Arrived to the User";
      case OrderStatus.arrived:
        return "Delivered to the User";
      default:
        return "";
    }
  }

  Future<void> handleButtonPress(String orderId) async {
    try {
      emit(OrderDetailsLoading());

      if (currentStatus == OrderStatus.accepted) {
        await _startOrderUseCase(orderId);
        currentStatus = OrderStatus.picked;
      } else {
        String newState;
        switch (currentStatus) {
          case OrderStatus.picked:
            newState = "out_for_delivery";
            currentStatus = OrderStatus.outForDelivery;
            break;
          case OrderStatus.outForDelivery:
            newState = "arrived";
            currentStatus = OrderStatus.arrived;
            break;
          case OrderStatus.arrived:
            newState = "delivered";
            currentStatus = OrderStatus.delivered;
            break;
          default:
            return;
        }
        await _updateOrderStateUseCase(orderId, newState);
      }

      emit(OrderStateUpdated());
    } catch (e) {
      emit(OrderDetailsError(e.toString()));
    }
  }
}
