import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';
import 'package:flowery_driver/domain/use_case/profile/logout_use_case.dart';
import 'package:flowery_driver/presentation/profile/view_model/profile_states.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/use_case/profile/get_logged_driver_info_use_case.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedDriverInfoUseCase getLoggedDriverInfoUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit(this.getLoggedDriverInfoUseCase, this.logoutUseCase)
      : super(ProfileInitialState());

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedDriverInfoLoadingState());
    var result = await getLoggedDriverInfoUseCase.invoke();
    switch (result) {
      case Success<DriverEntity?>():
        emit(GetLoggedDriverInfoSuccessState(driver: result.data));
        break;
      case Fail<DriverEntity?>():
        emit(GetLoggedDriverInfoErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> logout() async {
    final response = await logoutUseCase.invoke();
    switch (response) {
      case Success<String?>():
        emit(LogoutSuccessState(response.data));
      case Fail<String?>():
        emit(LogoutErrorState(getErrorMassageFromException(response.exception)));
    }
  }
}
