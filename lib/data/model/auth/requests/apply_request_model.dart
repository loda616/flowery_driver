class ApplyRequestBodyModel {
  String? country;
  String? firstName;
  String? lastName;
  String? vehicleTypeId;
  String? vehicleNumber;
  String? vehicleLicense;
  String? nationalId;
  String? nationalIdImage;
  String? email;
  String? password;
  String? rePassword;
  String? gender;
  String? phone;

  ApplyRequestBodyModel({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleTypeId,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nationalId,
    this.nationalIdImage,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "firstName": firstName,
      "lastName": lastName,
      "vehicleType": vehicleTypeId,
      "vehicleNumber": vehicleNumber,
      "vehicleLicense": vehicleLicense,
      "NID": nationalId,
      "NIDImg": nationalIdImage,
      "email": email,
      "password": password,
      "rePassword": rePassword,
      "gender": gender,
      "phone": phone,
    };
  }
}
