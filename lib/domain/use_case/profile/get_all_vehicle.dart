import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/profile/vehicle_entity.dart';
import '../../repository/profile/profile_repository.dart';

@injectable
class GetAllVehicleUseCase {
  final ProfileRepository profileRepository;
  GetAllVehicleUseCase({required this.profileRepository});
  Future<Result<List<VehicleEntity?>>> invoke() async {
    return await profileRepository.getAllVehicle();
  }
}
