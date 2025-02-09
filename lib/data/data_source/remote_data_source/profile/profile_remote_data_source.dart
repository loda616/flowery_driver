import 'dart:io';
import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import '../../../../core/api/api_result.dart';
import '../../../model/profile/profile_response/driver_model.dart';
import '../../../model/profile/profile_response/vehicle_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<DriverModel?>> getLoggedDriverInfo();
  Future<Result<VehicleModel?>> getVehicleInfo(String vehicleId);
  Future<Result<String?>> logout();
  Future<Result<DriverEntity?>> editProfile(Map<String, dynamic> body);
  Future<Result<String?>> uploadPhoto(File photo);
  Future<Result<List<VehicleModel?>>> getAllVehicles();

}
