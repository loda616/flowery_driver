import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide DioMediaType;
import 'package:http_parser/http_parser.dart';
import '../../../core/api/api_const.dart';
import '../../model/auth/requests/login_request_model.dart';
import '../../model/auth/requests/reset_password_request_model.dart';
import '../../model/auth/response/login_response_model.dart';
import '../../model/auth/response/sign_up_response_model.dart';

part 'auth_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiManager {
  @factoryMethod
  factory AuthApiManager(Dio dio) = _AuthApiManager;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> logIn(
      @Body() LoginRequestBodyModel loginRequestBody);

  @POST(ApiConstants.apply)
  @MultiPart()
  Future<SignUpResponseModel> applyDriver(
      @Part(name: 'country') String country,
      @Part(name: 'firstName') String firstName,
      @Part(name: 'lastName') String lastName,
      @Part(name: 'vehicleType') String vehicleType,
      @Part(name: 'vehicleNumber') String vehicleNumber,
      @Part(name: 'vehicleLicense', contentType: 'image/jpeg') File vehicleLicense,
      @Part(name: 'NID') String nID,
      @Part(name: 'NIDImg', contentType: 'image/jpeg') File nIDImg,
      @Part(name: 'email') String email,
      @Part(name: 'password') String password,
      @Part(name: 'rePassword') String rePassword,
      @Part(name: 'gender') String gender,
      @Part(name: 'phone') String phone);

  @POST(ApiConstants.forgotPassword)
  Future<String?> forgetPassword(@Body() Map<String, dynamic> email);

  @POST(ApiConstants.verifyResetCode)
  Future<String?> verifyResetCode(@Body() Map<String, dynamic> resetCode);

  @PUT(ApiConstants.resetPassword)
  Future<String?> resetPassword(@Body() ResetPasswordRequestBody resetPassword);
}
