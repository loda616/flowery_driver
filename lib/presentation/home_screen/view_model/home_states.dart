import '../../../domain/entity/pending_orders/order_entity.dart';

sealed class HomeState {}

final class PendingOrderInitialState extends HomeState {}

final class PendingOrderLoadingState extends HomeState {}

//getAllPendingOrders
final class PendingGetOrdersSuccessState extends HomeState {
  final List<OrderEntity?> orders;

  PendingGetOrdersSuccessState({required this.orders});
}

final class PendingGetOrdersErrorState extends HomeState {
  final String? errorMessage;

  PendingGetOrdersErrorState({this.errorMessage});
}
