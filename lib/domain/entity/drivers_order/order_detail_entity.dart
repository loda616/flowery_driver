import 'package:flowery_driver/domain/entity/drivers_order/order_item_entity.dart';
import 'package:flowery_driver/domain/entity/drivers_order/user_entity.dart';

class OrderDetailsEntity {
  final String? id;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final double? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;

  OrderDetailsEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });
}