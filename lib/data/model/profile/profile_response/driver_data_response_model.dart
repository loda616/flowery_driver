import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';

import 'driver_model.dart';

class DriverDataResponseModel {
  DriverDataResponseModel({
    this.message,
    this.driver,
  });

  DriverDataResponseModel.fromJson(dynamic json) {
    message = json['message'];
    driver =
        json['driver'] != null ? DriverModel.fromJson(json['driver']) : null;
  }
  String? message;
  DriverModel? driver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    return map;
  }

  DriverEntity? toEntity() {
    return DriverEntity(
        id: driver?.id,
        phone: driver?.phone,
        photo: driver?.photo,
        firstName: driver?.firstName,
        lastName: driver?.lastName,
        email: driver?.email,
        gender: driver?.gender,
        vehicleNumber: driver?.vehicleNumber,
        vehicleType: driver?.vehicleType,
        vehicleLicense: driver?.vehicleLicense,
        country: driver?.country);
  }
}
