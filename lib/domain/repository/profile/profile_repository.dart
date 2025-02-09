import 'dart:io';

import '../../../../core/api/api_result.dart';
import '../../../data/model/auth/requests/edite_profile_request_model.dart';
import '../../entity/profile/driver_entity.dart';
import '../../entity/profile/vehicle_entity.dart';

abstract class ProfileRepository {
  Future<Result<DriverEntity?>> getLoggedDriverInfo();
  Future<Result<VehicleEntity?>> getVehicleInfo(String vehicleId);
  Future<Result<List<VehicleEntity?>>> getAllVehicle();
  Future<Result<String?>> logout();
  Future<Result<DriverEntity?>> editeProfile(Map<String, dynamic> body);
  Future<Result<String?>> uploadPhoto(File photo);


}
