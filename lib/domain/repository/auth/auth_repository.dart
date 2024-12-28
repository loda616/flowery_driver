import '../../../core/api/api_result.dart';
import '../../../data/model/auth/requests/login_request_model.dart';
import '../../../data/model/auth/requests/reset_password_request_model.dart';
import '../../../data/model/auth/requests/sign_up_request_model.dart';

abstract class AuthRepository {
  Future<Result<String?>> logIn({
    required LoginRequestBodyModel loginRequestBody,
    required bool rememberMe,
  });
  Future<Result<String?>> apply(SignUpRequestBodyModel signUpRequestBody);
  Future<Result<String?>> resetPassword(ResetPasswordRequestBody resetPassword);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
}
