import 'driver_model.dart';

class DriverDataResponseModel {
  DriverDataResponseModel({
      this.message, 
      this.driver,});

  DriverDataResponseModel.fromJson(dynamic json) {
    message = json['message'];
    driver = json['driver'] != null ? DriverModel.fromJson(json['driver']) : null;
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

}