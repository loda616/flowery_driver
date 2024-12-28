import '../../../core/api/api_result.dart';
import '../../entity/vehicles/vehicle_type_entity.dart';

abstract class VehiclesRepository {
  Future<Result<List<VehicleType>?>> getAllVehiclesType();
}
