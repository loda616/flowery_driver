import 'package:flowery_driver/data/model/pending_orders/product_model.dart';
import 'package:flowery_driver/domain/entity/pending_orders/order_item.dart';

class OrderItemModel {
  OrderItemModel({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  OrderItemModel.fromJson(dynamic json) {
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }
  ProductModel? product;
  int? price;
  int? quantity;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }
  OrderItem? toEntity() {
    OrderItem(
        price: price,
        quantity: quantity,
        id: id,
        product: product?.toEntity());
    return null;
  }
}
