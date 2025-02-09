import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'apply_request_model.g.dart';

/************8
 * class ApplyRequestBodyModel {
    String? country;
    String? firstName;
    String? lastName;
    String? vehicleTypeId;
    String? vehicleNumber;
    File? vehicleLicense;
    String? nationalId;
    File? nationalIdImage;
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

 */
@JsonSerializable()
class ApplyRequestDto {
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  @JsonKey(name: 'NID')
  final String? nID;
  @JsonKey(name: 'NIDImg')
  final String? nIDImg;
  final String? email;
  final String? password;
  final String? rePassword;
  final String? gender;
  final String? phone;

  ApplyRequestDto(
      this.country,
      this.firstName,
      this.lastName,
      this.vehicleType,
      this.vehicleNumber,
      this.vehicleLicense,
      this.nID,
      this.nIDImg,
      this.email,
      this.password,
      this.rePassword,
      this.gender,
      this.phone);

  factory ApplyRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyRequestDtoToJson(this);
}
