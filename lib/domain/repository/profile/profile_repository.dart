
import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';

import '../../../../core/api/api_result.dart';

abstract class ProfileRepository {
  Future<Result<DriverEntity?>> getLoggedDriverInfo();
}
