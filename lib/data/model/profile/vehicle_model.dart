import '../../../domain/entity/profile/vehicle_entity.dart';

class VehicleModel {
  VehicleModel({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  VehicleModel.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['type'] = type;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

  VehicleEntity? toEntity() {
    VehicleEntity(
      id: id,
      type: type,
      image: image,
    );
    return null;
  }
}
