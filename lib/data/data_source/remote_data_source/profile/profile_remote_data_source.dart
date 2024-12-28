import 'package:flowery_driver/data/model/profile/driver_model.dart';

import '../../../../core/api/api_result.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<DriverModel?>> getLoggedDriverInfo();
  Future<Result<String?>> logout();
}
