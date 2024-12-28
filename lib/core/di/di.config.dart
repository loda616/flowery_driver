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

import '../../data/api/profile_api/profile_api_manager.dart' as _i592;
import '../../data/data_source/remote_data_source/profile/profile_remote_data_source.dart'
    as _i53;
import '../../data/data_source/remote_data_source/profile/profile_remote_data_source_impl.dart'
    as _i466;
import '../../data/repository/profile/profile_repository_impl.dart' as _i181;
import '../../domain/repository/profile/profile_repository.dart' as _i742;
import '../../domain/use_case/profile/get_logged_driver_info_use_case.dart'
    as _i337;
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
    gh.lazySingleton<_i592.ProfileApiManager>(
        () => _i592.ProfileApiManager(gh<_i361.Dio>()));
    gh.factory<_i53.ProfileRemoteDataSource>(() =>
        _i466.ProfileRemoteDataSourceImpl(
            apiManger: gh<_i592.ProfileApiManager>()));
    gh.factory<_i742.ProfileRepository>(() => _i181.ProfileRepositoryImpl(
        profileRemoteDataSource: gh<_i53.ProfileRemoteDataSource>()));
    gh.factory<_i337.GetLoggedDriverInfoUseCase>(() =>
        _i337.GetLoggedDriverInfoUseCase(
            profileRepository: gh<_i742.ProfileRepository>()));
    gh.factory<_i671.ProfileCubit>(
        () => _i671.ProfileCubit(gh<_i337.GetLoggedDriverInfoUseCase>()));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
