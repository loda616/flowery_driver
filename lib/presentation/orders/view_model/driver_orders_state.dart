import 'package:equatable/equatable.dart';
import '../../../domain/entity/drivers_order/order_entity.dart';

abstract class DriverOrdersState extends Equatable {
  const DriverOrdersState();

  @override
  List<Object?> get props => [];
}

class DriverOrdersInitial extends DriverOrdersState {}

class DriverOrdersLoading extends DriverOrdersState {}

class DriverOrdersSuccess extends DriverOrdersState {
  final List<OrderEntity?> orders;

  const DriverOrdersSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class DriverOrdersError extends DriverOrdersState {
  final String message;

  const DriverOrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
