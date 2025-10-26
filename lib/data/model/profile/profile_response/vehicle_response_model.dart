
import 'package:flowery_driver/data/model/profile/profile_response/vehicle_model.dart';

class VehicleResponseModel {
  VehicleResponseModel({
      this.message, 
      this.vehicle,});

  VehicleResponseModel.fromJson(dynamic json) {
    message = json['message'];
    vehicle = json['vehicle'] != null ? VehicleModel.fromJson(json['vehicle']) : null;
  }
  String? message;
  VehicleModel? vehicle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (vehicle != null) {
      map['vehicle'] = vehicle?.toJson();
    }
    return map;
  }

}