import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/profile/profile_repository.dart';

@injectable
class GetVehicleInfoUseCase {
  final ProfileRepository profileRepository;
  GetVehicleInfoUseCase({required this.profileRepository});
  Future<Result<VehicleEntity?>> invoke(String vehicleTypeId) async {
    return await profileRepository.getVehicleInfo(vehicleTypeId);
  }
}
