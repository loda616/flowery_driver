import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../api/profile_api/profile_api_manager.dart';
import '../../../model/profile/driver_model.dart';
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

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
