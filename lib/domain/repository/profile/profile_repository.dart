import '../../../../core/api/api_result.dart';
import '../../entity/profile/driver_entity.dart';

abstract class ProfileRepository {
  Future<Result<DriverEntity?>> getLoggedDriverInfo();
}
