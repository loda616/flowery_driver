import 'package:json_annotation/json_annotation.dart';

part 'order_details_response.g.dart';

@JsonSerializable()
class OrderDetailsResponse {
  final String id;
  final String status;
  final String orderDate;
  final StoreDetails store;
  final CustomerDetails customer;
  final List<OrderItem> items;
  final PaymentDetails payment;
  final double total;

  OrderDetailsResponse({
    required this.id,
    required this.status,
    required this.orderDate,
    required this.store,
    required this.customer,
    required this.items,
    required this.payment,
    required this.total,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsResponseToJson(this);
}

@JsonSerializable()
class StoreDetails {
  final String name;
  final String image;
  final String location;
  final String phone;

  StoreDetails({
    required this.name,
    required this.image,
    required this.location,
    required this.phone,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDetailsToJson(this);
}

@JsonSerializable()
class CustomerDetails {
  final String name;
  final String image;
  final String location;
  final String phone;

  CustomerDetails({
    required this.name,
    required this.image,
    required this.location,
    required this.phone,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable()
class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class PaymentDetails {
  final String method;
  final String status;

  PaymentDetails({
    required this.method,
    required this.status,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentDetailsToJson(this);
}