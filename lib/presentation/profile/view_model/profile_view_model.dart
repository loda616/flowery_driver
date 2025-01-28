import 'dart:io';

import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
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

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedDriverInfoUseCase _getLoggedDriverInfoUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetVehicleInfoUseCase _getVehicleInfoUseCase;
  final EditeProfileUseCase editeProfileUseCase;
  final UploadPhotoUseCase uploadPhotoUseCase;

  ProfileCubit(
      this.editeProfileUseCase,
      this.uploadPhotoUseCase,

      this._getLoggedDriverInfoUseCase,
    this._logoutUseCase,
    this._getVehicleInfoUseCase,
  ) : super(ProfileInitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? gender;
  String? photo;

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
  // Update user profile
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
        break;
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
      debugPrint("Upload failed: ${result.exception}");
    }}


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
