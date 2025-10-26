import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/model/auth/requests/reset_password_request_model.dart';
import '../../repository/auth/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  Future<Result<String?>> invoke(
      {required String email, required String newPassword}) {
    var requestBody =
        ResetPasswordRequestBody(email: email, newPassword: newPassword);
    return authRepository.resetPassword(requestBody);
  }
}
