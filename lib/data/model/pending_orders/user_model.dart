import 'package:flowery_driver/domain/entity/pending_orders/User.dart';

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    passwordChangedAt = json['passwordChangedAt'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? passwordChangedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['phone'] = phone;
    map['photo'] = photo;
    map['passwordChangedAt'] = passwordChangedAt;
    return map;
  }

  User? toEntity() {
    User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        photo: photo,
        phone: phone,
        passwordChangedAt: passwordChangedAt);
    return null;
  }
}
