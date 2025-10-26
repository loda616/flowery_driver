import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../domain/entity/auth/applu.dart';
import '../../../api/auth_api/auth_api_manager.dart';
import '../../../model/auth/requests/apply_request_model.dart';
import '../../../model/auth/requests/login_request_model.dart';
import '../../../model/auth/requests/reset_password_request_model.dart';
import '../../../model/auth/response/login_response_model.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthApiManager apiManger;

  AuthRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<LoginResponseModel?>> logIn(
      LoginRequestBodyModel loginRequestBody) {
    return executeApiCall<LoginResponseModel?>(() async {
      LoginResponseModel? message = await apiManger.logIn(loginRequestBody);
      return message;
    });
  }

  @override
  Future<Result<String?>> apply(ApplyRequestEntity signUpRequestBody) {
    return executeApiCall(() async {
      final response = await apiManger.applyDriver(
          signUpRequestBody.country!,
          signUpRequestBody.firstName!,
          signUpRequestBody.lastName!,
          signUpRequestBody.vehicleType!,
          signUpRequestBody.vehicleNumber!,
          signUpRequestBody.vehicleLicense! ,
          signUpRequestBody.nID!,
          signUpRequestBody.nIDImg! ,
          signUpRequestBody.email!,
          signUpRequestBody.password!,
          signUpRequestBody.rePassword!,
          signUpRequestBody.gender!,
          signUpRequestBody.phone!);
      return response.message;
    });
  }

  @override
  Future<Result<String?>> forgotPassword({required String email}) {
    return executeApiCall<String?>(() async {
      String? message = await apiManger.forgetPassword({'email': email});
      return message;
    });
  }

  @override
  Future<Result<String?>> verifyResetCode({required String resetCode}) {
    return executeApiCall<String?>(() async {
      String? message =
          await apiManger.verifyResetCode({"resetCode": resetCode});
      return message;
    });
  }

  @override
  Future<Result<String?>> resetPassword(
      ResetPasswordRequestBody resetPassword) {
    return executeApiCall<String?>(() async {
      final response = await apiManger.resetPassword(resetPassword);
      return response;
    });
  }
}
