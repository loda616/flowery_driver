import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/local/secure_storage.dart';
import '../../../core/local/token_manger.dart';
import '../../../domain/repository/auth/auth_repository.dart';
import '../../data_source/remote_data_source/auth/auth_remote_data_source.dart';
import '../../model/auth/requests/apply_request_model.dart';
import '../../model/auth/requests/login_request_model.dart';
import '../../model/auth/requests/reset_password_request_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Result<String?>> logIn({
    required LoginRequestBodyModel loginRequestBody,
    required bool rememberMe,
  }) async {
    final result = await dataSource.logIn(loginRequestBody);

    switch (result) {
      case Success():
        if (rememberMe) {
          SecureStorageFactory.writeData(key: 'rememberMe', value: 'true');
        }

        final token = result.data?.token;

        if (token == null || token.isEmpty) {
          final exception = Exception('Token is Empty, Please try again');
          return Fail(exception: exception);
        }

        await TokenManager.setToken(token: token);

        return Success();

      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<String?>> apply(ApplyRequestBodyModel signUpRequestBody) async {
    return await dataSource.apply(signUpRequestBody);
  }

  @override
  Future<Result<String?>> forgotPassword({required String email}) async {
    return await dataSource.forgotPassword(email: email);
  }

  @override
  Future<Result<String?>> verifyResetCode({required String resetCode}) async {
    return await dataSource.verifyResetCode(resetCode: resetCode);
  }

  @override
  Future<Result<String?>> resetPassword(
      ResetPasswordRequestBody resetPassword) async {
    return await dataSource.resetPassword(resetPassword);
  }
}
