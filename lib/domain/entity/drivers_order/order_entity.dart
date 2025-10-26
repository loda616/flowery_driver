import 'package:flowery_driver/domain/entity/drivers_order/order_detail_entity.dart' show OrderDetailsEntity;
import 'package:flowery_driver/domain/entity/drivers_order/store_entity.dart' show StoreEntity;

class OrderEntity {
  final String? id;
  final String? driver;
  final OrderDetailsEntity? order;  // Changed to match API structure
  final StoreEntity? store;
  final String? createdAt;
  final String? updatedAt;

  OrderEntity({
    this.id,
    this.driver,
    this.order,  // Changed field name to match
    this.store,
    this.createdAt,
    this.updatedAt,
  });
}