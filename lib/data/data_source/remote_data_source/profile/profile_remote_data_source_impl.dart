import 'dart:io';
import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../api/profile_api/profile_api_manager.dart';
import '../../../model/profile/profile_response/driver_model.dart';
import '../../../model/profile/profile_response/vehicle_model.dart';
import 'profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileApiManager apiManger;
  ProfileRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<DriverModel?>> getLoggedDriverInfo() async {
    return await executeApiCall<DriverModel?>(() async {
      var token = await _getToken();
      var driverModel = await apiManger.getLoggedDriverInfo(token);
      return driverModel?.driver;
    });
  }

  @override
  Future<Result<String?>> logout() async {
    return await executeApiCall<String?>(() async {
      var token = await _getToken();
      return await apiManger.logout(token);
    });
  }

  @override
  Future<Result<VehicleModel?>> getVehicleInfo(String vehicleId) async {
    return await executeApiCall<VehicleModel?>(() async {
      var token = await _getToken();
      var vehicleModel = await apiManger.getVehicleInfo(token, vehicleId);
      return vehicleModel?.vehicle;
    });
  }

  @override
  Future<Result<DriverEntity?>> editProfile(Map<String, dynamic> body) async {
    return await executeApiCall<DriverEntity?>(() async {
      var token = await _getToken();
      final editProfileModel = await apiManger.editProfile(token, body);
      return editProfileModel?.toEntity();
    });
  }

  @override
  Future<Result<String?>> uploadPhoto(File photo) {
    return executeApiCall(() async {
      var token = await _getToken();
      var response = await apiManger.uploadPhoto(token, photo);
      return response;
    });
  }

  @override
  Future<Result<List<VehicleModel?>>> getAllVehicles() {
    return executeApiCall<List<VehicleModel?>>(() async {
      var token = await _getToken();
      var vehicleModel = await apiManger.getAllVehicles(token);
      return vehicleModel?.vehicles ?? [];
    });
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
