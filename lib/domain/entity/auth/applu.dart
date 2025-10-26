import 'dart:io';

class ApplyRequestEntity {
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final File? vehicleLicense;
  final String? nID;
  final File? nIDImg;
  final String? email;
  final String? password;
  final String? rePassword;
  final String? gender;
  final String? phone;

  ApplyRequestEntity({this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.nID,
    this.nIDImg,
    this.vehicleLicense,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.phone});
}