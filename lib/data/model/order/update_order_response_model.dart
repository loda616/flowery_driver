
import 'package:flowery_driver/data/model/order/update_order_model.dart';

class UpdateOrderResponseModel {
  UpdateOrderResponseModel({
      this.message, 
      this.orders,});

  UpdateOrderResponseModel.fromJson(dynamic json) {
    message = json['message'];
    orders = json['orders'] != null ? UpdateOrdersModel.fromJson(json['orders']) : null;
  }
  String? message;
  UpdateOrdersModel? orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (orders != null) {
      map['orders'] = orders?.toJson();
    }
    return map;
  }

}