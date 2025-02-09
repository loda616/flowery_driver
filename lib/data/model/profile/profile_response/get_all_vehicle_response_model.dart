import 'package:flowery_driver/data/model/profile/profile_response/vehicle_model.dart';
import '../../metadata_model.dart';

class GetAllVehicleResponseModel {
  GetAllVehicleResponseModel({
      this.message, 
      this.metadata, 
      this.vehicles,});

  GetAllVehicleResponseModel.fromJson(dynamic json) {
    message = json['message'];
    metadata = json['metadata'] != null ? MetadataModel.fromJson(json['metadata']) : null;
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles?.add(VehicleModel.fromJson(v));
      });
    }
  }
  String? message;
  MetadataModel? metadata;
  List<VehicleModel>? vehicles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (vehicles != null) {
      map['vehicles'] = vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}