import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../data/model/auth/requests/apply_request_model.dart';
import '../../../../domain/entity/vehicles/vehicle_type_entity.dart';
import '../../../../domain/use_case/auth/apply_use_case.dart';
import '../../../../domain/use_case/vehicles/get_all_vehicles_use_case.dart';

part 'apply_state.dart';

@injectable
class ApplyViewModel extends BaseViewModel<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final GetAllVehiclesUseCase _getAllVehiclesUseCase;

  ApplyViewModel(
    this._signUpUseCase,
    this._getAllVehiclesUseCase,
  ) : super(SignUpInitial());

  List<VehicleType> vehicleTypes = [];

  void getAllVehiclesType() async {
    emit(GetVehiclesTypesLoading());
    final response = await _getAllVehiclesUseCase.invoke();

    switch (response) {
      case Success():
        vehicleTypes = response.data ?? [];
        emit(GetVehiclesTypesSuccess());

      case Fail():
        emit(
          GetVehiclesTypesFail(
              getErrorMassageFromException(response.exception)),
        );
    }
  }

  void apply(ApplyRequestBodyModel signUpData) async {
    emit(SignUpLoading());
    final response = await _signUpUseCase.invoke(signUpData);

    switch (response) {
      case Success<String?>():
        emit(SignUpSuccess(response.data));

      case Fail<String?>():
        emit(
          SignUpFail(getErrorMassageFromException(response.exception)),
        );
    }
  }
}
