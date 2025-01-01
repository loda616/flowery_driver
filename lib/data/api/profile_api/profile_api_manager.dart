import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../model/profile/driver_data_response_model.dart';
import '../../model/profile/vehicle_response_model.dart';
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
}
