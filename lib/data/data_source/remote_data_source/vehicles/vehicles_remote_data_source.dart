import '../../../../core/api/api_result.dart';
import '../../../model/vehicles/vehicle_types_response_model.dart';

abstract class VehiclesRemoteDataSource {
  Future<Result<VehicleTypesResponseModel?>> getAllVehiclesType();
}
