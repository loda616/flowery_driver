import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../data/model/auth/requests/edite_profile_request_model.dart';
import '../../repository/profile/profile_repository.dart';

@injectable
class EditeProfileUseCase {
  final ProfileRepository profileRepository;
  EditeProfileUseCase({required this.profileRepository});
  Future<Result<DriverEntity?>> invoke(EditeProfileRequestModel editeProfile) async {
    return await profileRepository.editeProfile(editeProfile);
  }
}
