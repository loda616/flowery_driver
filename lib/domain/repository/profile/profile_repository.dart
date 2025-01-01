
import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';

import '../../../../core/api/api_result.dart';
import '../../entity/profile/vehicle_entity.dart';

abstract class ProfileRepository {
  Future<Result<DriverEntity?>> getLoggedDriverInfo();
  Future<Result<VehicleEntity?>> getVehicleInfo(String vehicleId);
  Future<Result<String?>> logout();
}
