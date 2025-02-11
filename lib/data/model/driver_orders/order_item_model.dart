import 'package:flowery_driver/data/model/driver_orders/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/drivers_order/order_item_entity.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final ProductModel? product;
  final double? price;
  final int? quantity;
  final String? id;

  OrderItemModel({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
