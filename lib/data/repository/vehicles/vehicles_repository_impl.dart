import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entity/vehicles/vehicle_type_entity.dart';
import '../../../domain/repository/vehicles/vehicles_repository.dart';
import '../../data_source/remote_data_source/vehicles/vehicles_remote_data_source.dart';

@Injectable(as: VehiclesRepository)
class VehiclesRepositoryImpl extends VehiclesRepository {
  final VehiclesRemoteDataSource dataSource;

  VehiclesRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<VehicleType>?>> getAllVehiclesType() async {
    final result = await dataSource.getAllVehiclesType();

    switch (result) {
      case Success():
        final data = result.data?.data?.map((e) => e.toEntity()).toList() ?? [];
        return Success(data: data);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
