import 'dart:io';

import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import 'package:flowery_driver/domain/entity/vehicles/vehicle_type_entity.dart';
import 'package:flowery_driver/domain/use_case/profile/logout_use_case.dart';
import 'package:flowery_driver/presentation/profile/view_model/profile_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../data/model/auth/requests/edite_profile_request_model.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/use_case/profile/edit_profile_use_case.dart';
import '../../../domain/use_case/profile/get_logged_driver_info_use_case.dart';
import '../../../domain/use_case/profile/get_vehicle_info_use_case.dart';
import '../../../domain/use_case/profile/upload_photo_use_case.dart';
import '../../../domain/use_case/vehicles/get_all_vehicles_use_case.dart';


@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedDriverInfoUseCase _getLoggedDriverInfoUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetVehicleInfoUseCase _getVehicleInfoUseCase;
  final EditeProfileUseCase editeProfileUseCase;
  final UploadPhotoUseCase uploadPhotoUseCase;
  final GetAllVehiclesUseCase _getAllVehiclesUseCase;

  ProfileCubit(
    this.editeProfileUseCase,
    this.uploadPhotoUseCase,
    this._getAllVehiclesUseCase,
    this._getLoggedDriverInfoUseCase,
    this._logoutUseCase,
    this._getVehicleInfoUseCase,
  ) : super(ProfileInitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();

  String? gender;
  String? photo;
  String? vehicleId;
  DriverEntity? driver;
  VehicleEntity? vehicle;
  List<VehicleType> vehicles = [];

  @injectable
  Future<void> getAllVehicles() async {
    final result = await _getAllVehiclesUseCase.invoke();
    switch (result) {
      case Success():
        vehicles = result.data ?? [];
        emit(GetVehiclesTypeSuccess());
      case Fail():
        emit(GetVehiclesTypesError(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
    }

  }

  Future<void> updateVehicleType(String vehicleTypeId) async {
    emit(EditProfileLoadingState());
    await getLoggedUserInfo();
  }

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedDriverInfoLoadingState());
    final driverResult = await _getLoggedDriverInfoUseCase.invoke();
    switch (driverResult) {
      case Success():
        driver = driverResult.data;
        vehicleId = driver?.vehicleType;
        emit(GetLoggedDriverInfoSuccessState(driver: driver));
        vehicleNumberController.text = driver?.vehicleNumber ?? '';
        firstNameController.text = driver?.firstName ?? '';
        lastNameController.text = driver?.lastName ?? '';
        emailController.text = driver?.email ?? '';
        phoneController.text = driver?.phone ?? '';
        gender = driver?.gender;
        photo = driver?.photo;
      case Fail():
        emit(GetLoggedDriverInfoErrorState(
          errorMessage: getErrorMassageFromException(driverResult.exception),
        ));
    }
  }

  Future<void> getVehicleInfo() async {
    emit(GetVehicleInfoLoadingState());
    final vehicleResult = await _getVehicleInfoUseCase.invoke(vehicleId ?? '');
    switch (vehicleResult) {
      case Success():
        vehicle = vehicleResult.data;
        emit(GetVehicleInfoSuccessState(vehicle: vehicle,));
        vehicleTypeController.text = vehicle?.type??"" ;

      case Fail():
        emit(
          GetVehicleInfoErrorState(
            errorMessage: getErrorMassageFromException(vehicleResult.exception),
          ),
        );
    }
  }
  // Update profile
  Future<void> editeProfile() async {
    EditeProfileRequestModel editeProfile = EditeProfileRequestModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    emit(EditProfileLoadingState());

    var result = await editeProfileUseCase.invoke(editeProfile);
    switch (result) {
      case Success<DriverEntity?>():
        final updatedUser = result.data;
        firstNameController.text = updatedUser?.firstName ?? '';
        lastNameController.text = updatedUser?.lastName ?? '';
        emailController.text = updatedUser?.email ?? '';
        phoneController.text = updatedUser?.phone ?? '';
        emit(EditProfileSuccessState(driver: updatedUser));
        await getLoggedUserInfo();
      case Fail<DriverEntity?>():
        emit(EditProfileErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  // Upload profile photo
  Future<void> uploadPhoto(File photo) async {
    emit(UploadPhotoLoadingState());
    var result = await uploadPhotoUseCase.invoke(photo);
    if (result is Success<String?>) {
      emit(UploadPhotoSuccessState(message: result.data));
      await getLoggedUserInfo();
    } else if (result is Fail<String?>) {
      emit(UploadPhotoErrorState(
          errorMessage: getErrorMassageFromException(result.exception)));
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
// Profile form validation
  bool isFormField = true;

  String titleAppBar() {
    return isFormField ? "Profile" : "Update";
  }

  void changeFormField(bool isValid) {
    emit(ProfileInitialState());
    isFormField = isValid;
  }
}
