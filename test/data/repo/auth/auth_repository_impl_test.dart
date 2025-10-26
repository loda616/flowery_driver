import 'package:flowery_driver/core/api/api_result.dart';
import 'package:flowery_driver/data/data_source/remote_data_source/auth/auth_remote_data_source.dart';
import 'package:flowery_driver/data/model/auth/requests/login_request_model.dart';
import 'package:flowery_driver/data/model/auth/requests/reset_password_request_model.dart';
import 'package:flowery_driver/data/model/auth/response/login_response_model.dart';
import 'package:flowery_driver/data/repository/auth/auth_repository_impl.dart';
import 'package:flowery_driver/domain/entity/auth/applu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repository_impl_test.mocks.dart';
import 'package:flutter/services.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUpAll(() {
    final tException = Exception('Default dummy error');
    provideDummy<Result<LoginResponseModel?>>(Fail(exception: tException));
    provideDummy<Result<String?>>(Fail(exception: tException));
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockDataSource);

    const channel =
        MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return null;
    });
  });

  tearDown(() {
    const channel =
        MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('logIn', () {
    final tLoginRequestBody =
        LoginRequestBodyModel(email: 'test@test.com', password: 'password');

    test('should return Success when login is successful', () async {
      final tLoginResponse = LoginResponseModel(token: 'valid_token');
      when(mockDataSource.logIn(any))
          .thenAnswer((_) async => Success(data: tLoginResponse));

      final result = await repository.logIn(
          loginRequestBody: tLoginRequestBody, rememberMe: true);

      expect(result, isA<Success<String?>>());
      verify(mockDataSource.logIn(tLoginRequestBody));
    });

    test('should return Fail when token is null', () async {
      when(mockDataSource.logIn(any)).thenAnswer(
          (_) async => Success(data: LoginResponseModel(token: null)));

      final result = await repository.logIn(
          loginRequestBody: tLoginRequestBody, rememberMe: false);

      expect(result, isA<Fail>());
      expect((result as Fail).exception.toString(), contains('Token is Empty'));
    });

    test('should return Fail when dataSource fails', () async {
      final tException = Exception('Invalid credentials');
      when(mockDataSource.logIn(any))
          .thenAnswer((_) async => Fail(exception: tException));

      // Act
      final result = await repository.logIn(
          loginRequestBody: tLoginRequestBody, rememberMe: false);

      // Assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('apply', () {
    final tApplyRequestBody = ApplyRequestEntity();
    test('should call data source apply', () async {
      when(mockDataSource.apply(any))
          .thenAnswer((_) async => Success(data: 'Application Sent'));

      await repository.apply(tApplyRequestBody);

      verify(mockDataSource.apply(tApplyRequestBody));
    });
  });

  group('forgotPassword', () {
    const tEmail = 'forgot@test.com';
    test('should call data source forgotPassword', () async {
      when(mockDataSource.forgotPassword(email: anyNamed('email')))
          .thenAnswer((_) async => Success(data: 'Email sent'));

      await repository.forgotPassword(email: tEmail);

      verify(mockDataSource.forgotPassword(email: tEmail));
    });
  });

  group('verifyResetCode', () {
    const tResetCode = '123456';
    test('should call data source verifyResetCode', () async {
      when(mockDataSource.verifyResetCode(resetCode: anyNamed('resetCode')))
          .thenAnswer((_) async => Success(data: 'Code verified'));

      await repository.verifyResetCode(resetCode: tResetCode);

      verify(mockDataSource.verifyResetCode(resetCode: tResetCode));
    });
  });

  group('resetPassword', () {
    final tResetPasswordBody = ResetPasswordRequestBody(
      email: 'test@test.com',
      newPassword: 'newPassword123',
    );

    test('should call data source resetPassword', () async {
      when(mockDataSource.resetPassword(any))
          .thenAnswer((_) async => Success(data: 'Password reset'));

      await repository.resetPassword(tResetPasswordBody);

      verify(mockDataSource.resetPassword(tResetPasswordBody));
    });
  });
}
