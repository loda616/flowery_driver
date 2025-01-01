import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/use_case/profile/get_logged_driver_info_use_case.dart';
import 'profile_states.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedDriverInfoUseCase getLoggedDriverInfoUseCase;
  ProfileCubit(
    this.getLoggedDriverInfoUseCase,
  ) : super(ProfileInitialState());

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
}
