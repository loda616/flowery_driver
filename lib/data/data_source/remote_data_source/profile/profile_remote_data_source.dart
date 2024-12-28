import '../../../../core/api/api_result.dart';
import '../../../model/profile/driver_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<DriverModel?>> getLoggedDriverInfo();
}
