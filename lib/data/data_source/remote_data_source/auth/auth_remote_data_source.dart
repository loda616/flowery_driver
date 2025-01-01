import '../../../../core/api/api_result.dart';
import '../../../model/auth/requests/apply_request_model.dart';
import '../../../model/auth/requests/login_request_model.dart';
import '../../../model/auth/requests/reset_password_request_model.dart';
import '../../../model/auth/response/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<Result<LoginResponseModel?>> logIn(
      LoginRequestBodyModel loginRequestBody);
  Future<Result<String?>> apply(ApplyRequestBodyModel signUpRequestBody);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
  Future<Result<String?>> resetPassword(ResetPasswordRequestBody resetPassword);
}
