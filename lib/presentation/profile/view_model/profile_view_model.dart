import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import 'package:flowery_driver/domain/use_case/profile/logout_use_case.dart';
import 'package:flowery_driver/presentation/profile/view_model/profile_states.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/use_case/profile/get_logged_driver_info_use_case.dart';
import '../../../domain/use_case/profile/get_vehicle_info_use_case.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedDriverInfoUseCase _getLoggedDriverInfoUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetVehicleInfoUseCase _getVehicleInfoUseCase;

  ProfileCubit(
    this._getLoggedDriverInfoUseCase,
    this._logoutUseCase,
    this._getVehicleInfoUseCase,
  ) : super(ProfileInitialState());

  String? vehicleType;
  String? vehicleId;

  DriverEntity? driver;
  VehicleEntity? vehicle;

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedDriverInfoLoadingState());
    final driverResult = await _getLoggedDriverInfoUseCase.invoke();

    switch (driverResult) {
      case Success():
        driver = driverResult.data;
        vehicleId = driver?.vehicleType;
        getVehicleInfo();
        emit(GetLoggedDriverInfoSuccessState(driver: driver));
      case Fail():
        emit(GetLoggedDriverInfoErrorState(
          errorMessage: getErrorMassageFromException(driverResult.exception),
        ));
    }
  }

  Future<void> getVehicleInfo() async {
    emit(GetVehicleInfoLoadingState());

    final vehicleResult =
        await _getVehicleInfoUseCase.invoke(vehicleType ?? '');
    switch (vehicleResult) {
      case Success():
        vehicle = vehicleResult.data;
        emit(GetVehicleInfoSuccessState(
          vehicle: vehicleResult.data,
        ));

      case Fail():
        emit(
          GetVehicleInfoErrorState(
            errorMessage: getErrorMassageFromException(vehicleResult.exception),
          ),
        );
    }
  }

  Future<void> logout() async {
    final response = await _logoutUseCase.invoke();
    switch (response) {
      case Success<String?>():
        emit(LogoutSuccessState(response.data));
        break;
      case Fail<String?>():
        emit(LogoutErrorState(
          getErrorMassageFromException(response.exception),
        ));
    }
  }
}
