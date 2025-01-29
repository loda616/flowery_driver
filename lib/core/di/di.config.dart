// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/auth_api/auth_api_manager.dart' as _i515;
import '../../data/api/home_api/home_api_manager.dart' as _i48;
import '../../data/api/profile_api/profile_api_manager.dart' as _i592;
import '../../data/api/vehicles_api/vehicles_api_manager.dart' as _i471;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source.dart'
    as _i993;
import '../../data/data_source/remote_data_source/auth/auth_remote_data_source_impl.dart'
    as _i568;
import '../../data/data_source/remote_data_source/home/pending_orders_data_source.dart'
    as _i497;
import '../../data/data_source/remote_data_source/home/pending_orders_data_source_impl.dart'
    as _i567;
import '../../data/data_source/remote_data_source/profile/profile_remote_data_source.dart'
    as _i53;
import '../../data/data_source/remote_data_source/profile/profile_remote_data_source_impl.dart'
    as _i466;
import '../../data/data_source/remote_data_source/vehicles/vehicles_remote_data_source.dart'
    as _i249;
import '../../data/data_source/remote_data_source/vehicles/vehicles_remote_data_source_impl.dart'
    as _i885;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/home/pending_orders_repo_impl.dart' as _i547;
import '../../data/repository/profile/profile_repository_impl.dart' as _i181;
import '../../data/repository/vehicles/vehicles_repository_impl.dart' as _i760;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/home/pending_orders_repo.dart' as _i1056;
import '../../domain/repository/profile/profile_repository.dart' as _i742;
import '../../domain/repository/vehicles/vehicles_repository.dart' as _i266;
import '../../domain/use_case/auth/apply_use_case.dart' as _i156;
import '../../domain/use_case/auth/forgot_password_use_case.dart' as _i120;
import '../../domain/use_case/auth/login_use_case.dart' as _i408;
import '../../domain/use_case/auth/reset_password_use_case.dart' as _i603;
import '../../domain/use_case/auth/verify_reset_code_use_case.dart' as _i759;
import '../../domain/use_case/home/pending_orders_use_case.dart' as _i442;
import '../../domain/use_case/profile/edit_profile_use_case.dart' as _i11;
import '../../domain/use_case/profile/get_logged_driver_info_use_case.dart'
    as _i337;
import '../../domain/use_case/profile/get_vehicle_info_use_case.dart' as _i897;
import '../../domain/use_case/profile/logout_use_case.dart' as _i147;
import '../../domain/use_case/profile/upload_photo_use_case.dart' as _i659;
import '../../domain/use_case/vehicles/get_all_vehicles_use_case.dart'
    as _i1011;
import '../../presentation/auth/apply/view_model/apply_view_model.dart'
    as _i759;
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart'
    as _i351;
import '../../presentation/auth/login/view_model/login_cubit.dart' as _i97;
import '../../presentation/home_screen/view_model/home_view_model.dart'
    as _i726;
import '../../presentation/profile/view_model/profile_view_model.dart' as _i671;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i763.DioFactory>(() => _i763.DioFactory());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i515.AuthApiManager>(
        () => _i515.AuthApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i48.HomeApiManager>(
        () => _i48.HomeApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i592.ProfileApiManager>(
        () => _i592.ProfileApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i471.VehiclesApiManager>(
        () => _i471.VehiclesApiManager(gh<_i361.Dio>()));
    gh.factory<_i497.HomeRemoteDataSource>(() =>
        _i567.ProfileRemoteDataSourceImpl(
            apiManger: gh<_i48.HomeApiManager>()));
    gh.factory<_i249.VehiclesRemoteDataSource>(() =>
        _i885.VehiclesRemoteDataSourceImpl(
            apiManger: gh<_i471.VehiclesApiManager>()));
    gh.factory<_i266.VehiclesRepository>(() =>
        _i760.VehiclesRepositoryImpl(gh<_i249.VehiclesRemoteDataSource>()));
    gh.factory<_i1011.GetAllVehiclesUseCase>(
        () => _i1011.GetAllVehiclesUseCase(gh<_i266.VehiclesRepository>()));
    gh.factory<_i993.AuthRemoteDataSource>(() =>
        _i568.AuthRemoteDataSourceImpl(apiManger: gh<_i515.AuthApiManager>()));
    gh.factory<_i912.AuthRepository>(
        () => _i392.AuthRepositoryImpl(gh<_i993.AuthRemoteDataSource>()));
    gh.factory<_i603.ResetPasswordUseCase>(() =>
        _i603.ResetPasswordUseCase(authRepository: gh<_i912.AuthRepository>()));
    gh.factory<_i1056.PendingOrderRepository>(() =>
        _i547.PendingOrderRepositoryImpl(gh<_i497.HomeRemoteDataSource>()));
    gh.factory<_i120.ForgotPasswordUseCase>(() =>
        _i120.ForgotPasswordUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i759.VerifyResetCodeUseCase>(() =>
        _i759.VerifyResetCodeUseCase(repository: gh<_i912.AuthRepository>()));
    gh.factory<_i53.ProfileRemoteDataSource>(() =>
        _i466.ProfileRemoteDataSourceImpl(
            apiManger: gh<_i592.ProfileApiManager>()));
    gh.factory<_i442.GetPendingOrderUseCase>(() => _i442.GetPendingOrderUseCase(
        orderRepository: gh<_i1056.PendingOrderRepository>()));
    gh.factory<_i408.LogInUseCase>(
        () => _i408.LogInUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i742.ProfileRepository>(() => _i181.ProfileRepositoryImpl(
        profileRemoteDataSource: gh<_i53.ProfileRemoteDataSource>()));
    gh.factory<_i156.SignUpUseCase>(
        () => _i156.SignUpUseCase(gh<_i912.AuthRepository>()));
    gh.factory<_i97.LoginViewModel>(
        () => _i97.LoginViewModel(gh<_i408.LogInUseCase>()));
    gh.factory<_i147.LogoutUseCase>(
        () => _i147.LogoutUseCase(gh<_i742.ProfileRepository>()));
    gh.factory<_i11.EditeProfileUseCase>(() => _i11.EditeProfileUseCase(
        profileRepository: gh<_i742.ProfileRepository>()));
    gh.factory<_i337.GetLoggedDriverInfoUseCase>(() =>
        _i337.GetLoggedDriverInfoUseCase(
            profileRepository: gh<_i742.ProfileRepository>()));
    gh.factory<_i897.GetVehicleInfoUseCase>(() => _i897.GetVehicleInfoUseCase(
        profileRepository: gh<_i742.ProfileRepository>()));
    gh.factory<_i659.UploadPhotoUseCase>(() => _i659.UploadPhotoUseCase(
        profileRepository: gh<_i742.ProfileRepository>()));
    gh.factory<_i759.ApplyViewModel>(() => _i759.ApplyViewModel(
          gh<_i156.SignUpUseCase>(),
          gh<_i1011.GetAllVehiclesUseCase>(),
        ));
    gh.factory<_i351.ForgetPasswordCubit>(() => _i351.ForgetPasswordCubit(
          gh<_i120.ForgotPasswordUseCase>(),
          gh<_i759.VerifyResetCodeUseCase>(),
          gh<_i603.ResetPasswordUseCase>(),
        ));
    gh.factory<_i726.HomeCubit>(
        () => _i726.HomeCubit(gh<_i442.GetPendingOrderUseCase>()));
    gh.factory<_i671.ProfileCubit>(() => _i671.ProfileCubit(
          gh<_i11.EditeProfileUseCase>(),
          gh<_i659.UploadPhotoUseCase>(),
          gh<_i1011.GetAllVehiclesUseCase>(),
          gh<_i337.GetLoggedDriverInfoUseCase>(),
          gh<_i147.LogoutUseCase>(),
          gh<_i897.GetVehicleInfoUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
