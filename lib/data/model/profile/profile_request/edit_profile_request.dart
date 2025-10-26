class EditeProfileRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  EditeProfileRequestModel(
      {this.email, this.lastName, this.firstName, this.phone,});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["email"] = email;
    map["phone"] = phone;
    return map;
  }
}
class UpdateVehicleRequestModel {
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;

  UpdateVehicleRequestModel({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  Map<String, dynamic> toJson() => {
    'vehicleType': vehicleType,
    'vehicleNumber': vehicleNumber,
    'vehicleLicense': vehicleLicense,
  };
}
