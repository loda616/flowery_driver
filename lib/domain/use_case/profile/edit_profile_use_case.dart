import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../repository/profile/profile_repository.dart';

@injectable
class EditeProfileUseCase {
  final ProfileRepository profileRepository;
  EditeProfileUseCase({required this.profileRepository});
  Future<Result<DriverEntity?>> invoke(Map<String, dynamic> body) async {
    return await profileRepository.editeProfile(body);
  }
}
