import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowery_driver/core/base/base_view_model.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/fire_base/notificatio_service.dart';
import '../../../data/model/order/UpdateOrderDetailsRequestBody.dart';
import '../../../domain/entity/pending_orders/order_entity.dart';
import '../../../domain/use_case/home/pending_orders_use_case.dart';
import '../../../domain/use_case/order_details/start_order_use_case.dart';
import '../../../domain/use_case/order_details/update_order_state_use_case.dart';
import 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends BaseViewModel<OrderState> {
  final UpdateOrderStateUseCase _updateOrderStateUseCase;
  final StartOrderUseCase _startOrderUseCase;
  GetPendingOrderUseCase orderUseCase;
  OrderDetailsCubit(
      this._updateOrderStateUseCase, this._startOrderUseCase, this.orderUseCase)
      : super(OrderStateInitial());
  final NotificationService _notificationService = NotificationService();

  List<OrderEntity?> orderEntity = [];
  int currentStep = 1;
  OrderStatus currentStatus = OrderStatus.accepted;
  final Map<OrderStatus, String> statusStateMap = {
    OrderStatus.accepted: "pending",
    OrderStatus.picked: "inProgress",
    OrderStatus.outForDelivery: "inProgress",
    OrderStatus.arrived: "inProgress",
    OrderStatus.delivered: "completed"
  };

  Future<void> getPendingOrders() async {
    if (isClosed) return;
    emit(OrderStateLoading());

    var result = await orderUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success():
        orderEntity = result.data ?? [];
        emit(PendingGetOrdersSuccessState(orders: result.data ?? []));
      case Fail():
        emit(PendingGetOrdersErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> startOrder(String orderId) async {
    if (isClosed) return;
    emit(OrderStateLoading());
    await getPendingOrders();
    if (isClosed) return;
    var result = await _startOrderUseCase.call(orderId);
    if (isClosed) return;

    switch (result) {
      case Success():
        emit(OrderDetailsSuccess(ordersEntity: result.data));
      case Fail():
        emit(OrderDetailsError(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> updateOrderState(
      String orderId, UpdateOrderDetailsRequestBody state) async {
    if (isClosed) return;
    var result = await _updateOrderStateUseCase.call(orderId, state);
    if (isClosed) return;

    switch (result) {
      case Success():
        emit(OrderDetailsSuccess(ordersEntity: result.data));
      case Fail():
        emit(OrderDetailsError(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }


  Future<void> handleButtonPress(String orderId,) async {
    String notificationMessage = "";

    if (currentStatus == OrderStatus.accepted) {
      var startResult = await _startOrderUseCase.call(orderId);
      switch (startResult) {
        case Success():
          currentStatus = OrderStatus.picked;
          currentStep = 2;
          notificationMessage = "Your order is now in the preparation 🚚";
          await updateOrderState(
              orderId, UpdateOrderDetailsRequestBody(state: "inProgress"));
          emit(OrderDetailsSuccess(ordersEntity: startResult.data));
        case Fail():
          emit(OrderDetailsError(
              errorMessage:
                  getErrorMassageFromException(startResult.exception)));
          return;
      }
    } else {
      switch (currentStatus) {
        case OrderStatus.picked:
          currentStatus = OrderStatus.outForDelivery;
          currentStep = 3;
          notificationMessage = "The driver is on his way to you!🛵";
          await updateOrderState(
              orderId, UpdateOrderDetailsRequestBody(state: "inProgress"));
          break;
        case OrderStatus.outForDelivery:
          currentStatus = OrderStatus.arrived;
          currentStep = 4;
          notificationMessage = "The driver has arrived at your location📍";
          await updateOrderState(
              orderId, UpdateOrderDetailsRequestBody(state: "inProgress"));
          break;
        case OrderStatus.arrived:
          currentStatus = OrderStatus.delivered;
          currentStep = 5;
          notificationMessage = "The order was delivered successfully✅";
          await updateOrderState(
              orderId, UpdateOrderDetailsRequestBody(state: "completed"));
          break;
        case OrderStatus.delivered:
          return;
        case OrderStatus.accepted:
          break;
      }

      var result = await _startOrderUseCase.call(orderId);
      switch (result) {
        case Success():
          emit(OrderDetailsSuccess(ordersEntity: result.data));
        case Fail():
          emit(OrderDetailsError(
              errorMessage: getErrorMassageFromException(result.exception)));
      }
    }

  }
}

String getButtonText(OrderStatus status) {
  switch (status) {
    case OrderStatus.accepted:
      return "Arrived at Pickup Point";
    case OrderStatus.picked:
      return "Start Deliver";
    case OrderStatus.outForDelivery:
      return "Arrived to user";
    case OrderStatus.arrived:
      return "Delivered to user";
    case OrderStatus.delivered:
      return "Order Completed";
  }
}

enum OrderStatus { accepted, picked, outForDelivery, arrived, delivered }
