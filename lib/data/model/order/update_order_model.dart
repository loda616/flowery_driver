
import 'package:flowery_driver/data/model/order/update_order_item_model.dart';
import 'package:flowery_driver/domain/entity/order_details/update_order_entity.dart';

class UpdateOrdersModel {
  UpdateOrdersModel({
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
      this.v,});

  UpdateOrdersModel.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(UpdateOrderItemModel.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'] is num ? json['totalPrice'] : 0;
    paymentType = json['paymentType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderNumber = json['orderNumber'];
    v = json['__v'];
  }
  String? id;
  String? user;
  List<UpdateOrderItemModel>? orderItems;
   num? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    map['totalPrice'] = totalPrice;
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['state'] = state;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['orderNumber'] = orderNumber;
    map['__v'] = v;
    return map;
  }
  UpdateOrdersEntity toEntity() {
    return UpdateOrdersEntity(
      id: id,
      user: user,
      totalPrice: totalPrice is num ? totalPrice : 0,
      isPaid: isPaid,
      paymentType: paymentType,
      isDelivered: isDelivered,
      state: state,
      orderNumber: orderNumber,
      orderItems: orderItems!.map((orderItem) => orderItem.toEntity()).toList(),
    );
  }

}