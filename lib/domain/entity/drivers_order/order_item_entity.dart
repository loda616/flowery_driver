import 'package:flowery_driver/domain/entity/drivers_order/product_entity.dart';

class OrderItemEntity {
  final ProductEntity? product;
  final double? price;
  final int? quantity;
  final String? id;

  OrderItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}