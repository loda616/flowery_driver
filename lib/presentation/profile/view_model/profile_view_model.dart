import 'package:flowery_driver/domain/use_case/profile/logout_use_case.dart';
import 'package:flowery_driver/presentation/profile/view_model/profile_states.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/use_case/profile/get_logged_driver_info_use_case.dart';
import '../../../domain/use_case/profile/get_vehicle_info_use_case.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedDriverInfoUseCase _getLoggedDriverInfoUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetVehicleInfoUseCase _getVehicleInfoUseCase;

  String? vehicleType;

  ProfileCubit(
    this._getLoggedDriverInfoUseCase,
    this._logoutUseCase,
    this._getVehicleInfoUseCase,
  ) : super(ProfileInitialState());

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedDriverInfoLoadingState());
    final driverResult = await _getLoggedDriverInfoUseCase.invoke();
    print('Driver Result: $driverResult');
    switch (driverResult) {
      case Success():
        final driver = driverResult.data;
        if (driver?.vehicleType != null) {
          final vehicleResult =
              await _getVehicleInfoUseCase.invoke(driver!.vehicleType!);
          switch (vehicleResult) {
            case Success():
              emit(GetLoggedDriverInfoSuccessState(
                driver: driver,
                vehicle: vehicleResult.data,
              ));
              break;
            case Fail():
              emit(GetLoggedDriverInfoErrorState(
                errorMessage:
                    getErrorMassageFromException(vehicleResult.exception),
              ));
          }
        } else {
          emit(GetLoggedDriverInfoSuccessState(driver: driver, vehicle: null));
        }
        break;
      case Fail():
        emit(GetLoggedDriverInfoErrorState(
          errorMessage: getErrorMassageFromException(driverResult.exception),
        ));
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
