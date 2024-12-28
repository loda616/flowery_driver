import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/vehicles/vehicle_type_entity.dart';
import '../../repository/vehicles/vehicles_repository.dart';

@injectable
class GetAllVehiclesUseCase {
  final VehiclesRepository _repo;

  GetAllVehiclesUseCase(this._repo);

  Future<Result<List<VehicleType>?>> invoke() async {
    return await _repo.getAllVehiclesType();
  }
}
