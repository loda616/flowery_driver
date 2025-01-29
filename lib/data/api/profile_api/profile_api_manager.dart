import 'dart:io';
import 'package:dio/dio.dart' hide DioMediaType;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../model/auth/requests/edite_profile_request_model.dart';
import '../../model/profile/profile_response/driver_data_response_model.dart';
import '../../model/profile/profile_response/vehicle_response_model.dart';

part 'profile_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileApiManager {
  @factoryMethod
  factory ProfileApiManager(Dio dio) = _ProfileApiManager;

  @GET(ApiConstants.getLoggedDriverInfo)
  Future<DriverDataResponseModel?> getLoggedDriverInfo(
      @Header("Authorization") String token);

  @GET(ApiConstants.getVehicleInfo)
  Future<VehicleResponseModel?> getVehicleInfo(
    @Header("Authorization") String token,
    @Path("vehicleId") String vehicleId,
  );
  @GET(ApiConstants.logout)
  Future<String?> logout(@Header("Authorization") String token);

  @PUT(ApiConstants.editProfile)
  Future<DriverDataResponseModel?> editProfile(
    @Header('Authorization') String token,
    @Body() EditeProfileRequestModel editeProfile,
  );

  @PUT(ApiConstants.uploadPhoto)
  @MultiPart()
  Future<String?> uploadPhoto(
    @Header("Authorization") String token,
    @Part(name: "photo", contentType: "image/jpeg") File photo,
  );
}
