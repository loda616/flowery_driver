import 'package:flowery_driver/data/model/profile/driver_model.dart';
import 'package:flowery_driver/data/model/profile/vehicle_model.dart';

import '../../../../core/api/api_result.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<DriverModel?>> getLoggedDriverInfo();
  Future<Result<VehicleModel?>> getVehicleInfo(String vehicleId);
  Future<Result<String?>> logout();
}
