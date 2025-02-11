import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/drivers_order/order_entity.dart';
import 'order_detail_model.dart';
import 'store_model.dart';

part 'driver_order_model.g.dart';

@JsonSerializable()
class DriverOrderModel {
  final String? id;
  final String? driver;
  final OrderDetailModel? order;
  final StoreModel? store;
  final String? createdAt;
  final String? updatedAt;

  DriverOrderModel({
    this.id,
    this.driver,
    this.order,
    this.store,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DriverOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrderModelToJson(this);

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      driver: driver,
      order: order?.toEntity(),
      store: store?.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}