import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../api/vehicles_api/vehicles_api_manager.dart';
import '../../../model/vehicles/vehicle_types_response_model.dart';
import 'vehicles_remote_data_source.dart';

@Injectable(as: VehiclesRemoteDataSource)
class VehiclesRemoteDataSourceImpl extends VehiclesRemoteDataSource {
  VehiclesApiManager apiManger;

  VehiclesRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<VehicleTypesResponseModel?>> getAllVehiclesType() async {
    return executeApiCall<VehicleTypesResponseModel?>(() async {
      final result = await apiManger.getAllVehiclesType();
      return result;
    });
  }
}
