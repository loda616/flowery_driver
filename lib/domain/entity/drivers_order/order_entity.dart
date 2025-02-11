import 'package:flowery_driver/domain/entity/drivers_order/order_detail_entity.dart';
import 'package:flowery_driver/domain/entity/drivers_order/store_entity.dart';

class OrderEntity {
  final String? id;
  final String? driver;
  final OrderDetailEntity? order;
  final StoreEntity? store;
  final String? createdAt;
  final String? updatedAt;

  OrderEntity({
    this.id,
    this.driver,
    this.order,
    this.store,
    this.createdAt,
    this.updatedAt,
  });
}