import 'package:flowery_driver/domain/entity/order_details/update_order_item_entity.dart';

class UpdateOrderItemModel {
  UpdateOrderItemModel({
    this.product,
    this.price,
    this.quantity,
    this.id,});

  UpdateOrderItemModel.fromJson(dynamic json) {
    product = json['product'];
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }

  String? product;
  int? price;
  int? quantity;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = product;
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }

  UpdateOrderItemEntity toEntity() {
    return UpdateOrderItemEntity(
      product: product,
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}