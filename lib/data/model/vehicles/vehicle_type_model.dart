import '../../../domain/entity/vehicles/vehicle_type_entity.dart';

class VehicleTypeModel {
  final String? id;
  final String? type;
  final String? imageUrl;

  VehicleTypeModel({
    this.id,
    this.type,
    this.imageUrl,
  });

  VehicleType toEntity() {
    return VehicleType(
      id: id,
      type: type,
      imageUrl: imageUrl,
    );
  }

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      id: json['_id'],
      type: json['type'],
      imageUrl: json['image'],
    );
  }
}
