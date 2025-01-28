import 'User.dart';
import 'Store.dart';
import 'order_item.dart';

class OrderEntity {
  OrderEntity({
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
      this.v, 
      this.store,});

  String? id;
  User? user;
  List<OrderItem?>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? v;
  Store? store;


}