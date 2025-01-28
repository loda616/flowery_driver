import '../../../presentation/order_details/widget/order_status_indicator.dart';

class OrderDetails {
  final String id;
  final OrderStatus status;
  final String orderDate;
  //final Store store;
  //final Customer customer;
  //final List<Item> items;
  //final Payment payment;
  final double total;

  OrderDetails({
    required this.id,
    required this.status,
    required this.orderDate,
    //required this.store,
    //required this.customer,
    //required this.items,
    //required this.payment,
    required this.total,
  });
}