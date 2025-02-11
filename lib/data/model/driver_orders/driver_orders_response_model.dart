import 'package:json_annotation/json_annotation.dart';
import '../metadata_model.dart';
import 'driver_order_model.dart';

part 'driver_orders_response_model.g.dart';

@JsonSerializable()
class DriverOrdersResponseModel {
  final String? message;
  final MetadataModel? metadata;
  final List<DriverOrderModel>? orders;

  DriverOrdersResponseModel({
    this.message,
    this.metadata,
    this.orders,
  });

  factory DriverOrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DriverOrdersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrdersResponseModelToJson(this);
}