import 'package:equatable/equatable.dart';

import '../../../domain/entity/order_details/update_order_entity.dart';
import '../../../domain/entity/pending_orders/order_entity.dart';

sealed class OrderState {}
class OrderStateInitial extends OrderState {}

class OrderStateLoading extends OrderState {}

//getAllPendingOrders
final class PendingGetOrdersSuccessState extends OrderState {
  final List<OrderEntity?> orders;

  PendingGetOrdersSuccessState({required this.orders});
}

final class PendingGetOrdersErrorState extends OrderState {
  final String? errorMessage;

  PendingGetOrdersErrorState({this.errorMessage});
}


class OrderDetailsSuccess extends OrderState {
  final UpdateOrdersEntity? ordersEntity;
   OrderDetailsSuccess({required this.ordersEntity});
}

class OrderDetailsError extends OrderState {
  final String errorMessage;

  OrderDetailsError({required this.errorMessage});

}

class StartOrderSuccess extends OrderState {
  final UpdateOrdersEntity? ordersEntity;
  StartOrderSuccess({required this.ordersEntity});

}

class StartOrderError extends OrderState {
  final String errorMessage;

  StartOrderError({required this.errorMessage});
}
