import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/profile/profile_repository.dart';

@injectable
class LogoutUseCase {
  ProfileRepository profileRepository;

  LogoutUseCase(this.profileRepository);

  Future<Result<String?>> invoke() {
    return profileRepository.logout();
  }
}
