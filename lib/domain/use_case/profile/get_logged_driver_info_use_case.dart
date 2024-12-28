import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../entity/profile/driver_entity.dart';
import '../../repository/profile/profile_repository.dart';

@injectable
class GetLoggedDriverInfoUseCase {
  final ProfileRepository profileRepository;
  GetLoggedDriverInfoUseCase({required this.profileRepository});
  Future<Result<DriverEntity?>> invoke() async {
    return await profileRepository.getLoggedDriverInfo();
  }
}
