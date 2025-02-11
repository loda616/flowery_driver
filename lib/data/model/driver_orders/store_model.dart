import 'package:flowery_driver/domain/entity/drivers_order/store_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';
@JsonSerializable()
class StoreModel {
  final String? name;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? latLong;

  StoreModel({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  StoreEntity toEntity() {
    return StoreEntity(
      name: name,
      image: image,  // Pass image to entity
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}