import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../data/model/auth/requests/apply_request_model.dart';
import '../../../../domain/entity/auth/applu.dart';
import '../../../../domain/entity/vehicles/vehicle_type_entity.dart';
import '../../../../domain/use_case/auth/apply_use_case.dart';
import '../../../../domain/use_case/vehicles/get_all_vehicles_use_case.dart';
part 'apply_state.dart';

@injectable
class ApplyViewModel extends BaseViewModel<ApplyState> {
  final SignUpUseCase _signUpUseCase;
  final GetAllVehiclesUseCase _getAllVehiclesUseCase;

  ApplyViewModel(
    this._signUpUseCase,
    this._getAllVehiclesUseCase,
  ) : super(ApplyInitial());

  List<VehicleType> vehicleTypes = [];
  TextEditingController countryController = TextEditingController();
  TextEditingController firstLegalNameController = TextEditingController();
  TextEditingController secondLegalNameController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleLicenseController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController idImageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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

  void apply(ApplyRequestEntity signUpData) async {
    emit(ApplyLoading());
    final response = await _signUpUseCase.invoke(signUpData);
    switch (response) {
      case Success<String?>():
        emit(ApplySuccess(response.data));
      case Fail<String?>():
        print("Apply Error: ${response.exception}");
        emit(ApplyFail(getErrorMassageFromException(response.exception)));

    }
  }


}
