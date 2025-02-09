import 'dart:io';
import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import 'package:flowery_driver/domain/entity/vehicles/vehicle_type_entity.dart';
import 'package:flowery_driver/domain/use_case/profile/logout_use_case.dart';
import 'package:flowery_driver/presentation/profile/view_model/profile_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
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
  TextEditingController vehicleLicenseController = TextEditingController();

  String? gender;
  String? photo;
  String? vehicleId;
  DriverEntity? driver;
  VehicleEntity? vehicle;
  List<VehicleType> vehicles = [];
  List<VehicleEntity> vehicleEntity = [];
  List<String> vehicleTypes = [];

  Map<String, String> vehicleMap = {};
  Future<void> getAllVehicles() async {
    emit(GetVehiclesTypeLoading());
    final result = await _getAllVehiclesUseCase.invoke();
    switch (result) {
      case Success():
        if (result.data != null) {
          vehicles = result.data!;
        }
        emit(GetVehiclesTypeSuccess());
      case Fail():
        emit(GetVehiclesTypesError(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
    }
  }

  Future<void> updateVehicleInfo(
      String vehicleNumber, String vehicleLicense, String vehicleTypeId) async {
    emit(EditProfileLoadingState());

    Map<String, dynamic> vehicleData = {
      'vehicleNumber': vehicleNumber,
      'vehicleLicense': vehicleLicense,
      'vehicleType': vehicleTypeId,
    };

    final result = await editeProfileUseCase.invoke(vehicleData);

    switch (result) {
      case Success<DriverEntity?>():
        final updatedUser = result.data;
        vehicleNumberController.text = updatedUser?.vehicleNumber ?? '';
        vehicleLicenseController.text = updatedUser?.vehicleLicense ?? '';
        vehicleId = updatedUser?.vehicleType;
        emit(EditProfileSuccessState(driver: updatedUser));
        await getLoggedUserInfo();
      case Fail<DriverEntity?>():
        emit(EditProfileErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedDriverInfoLoadingState());
    final driverResult = await _getLoggedDriverInfoUseCase.invoke();
    switch (driverResult) {
      case Success():
        driver = driverResult.data;
        vehicleId = driver?.vehicleType;
        await getAllVehicles();
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
        emit(GetVehicleInfoSuccessState(
          vehicle: vehicle,
        ));
      //  vehicleTypeController.text = vehicle?.type??"" ;

      case Fail():
        emit(
          GetVehicleInfoErrorState(
            errorMessage: getErrorMassageFromException(vehicleResult.exception),
          ),
        );
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> profileData = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
      };
      editeProfile(profileData);
    }
  }

  Future<void> editeProfile(Map<String, dynamic> profileData) async {
    emit(EditProfileLoadingState());

    var result = await editeProfileUseCase.invoke(profileData);
    switch (result) {
      case Success<DriverEntity?>():
        final updatedUser = result.data;
        if (updatedUser != null) {
          driver = updatedUser;
          vehicleNumberController.text = updatedUser.vehicleNumber ?? '';
          firstNameController.text = updatedUser.firstName ?? '';
          lastNameController.text = updatedUser.lastName ?? '';
          emailController.text = updatedUser.email ?? '';
          phoneController.text = updatedUser.phone ?? '';
        }
        emit(EditProfileSuccessState(driver: driver));
        await getLoggedUserInfo();
        break;
      case Fail<DriverEntity?>():
        emit(EditProfileErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
        break;
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

  void updateDriverInfo(DriverEntity updatedDriver) {
    driver = updatedDriver;
    vehicleNumberController.text = updatedDriver.vehicleNumber ?? '';
    emit(GetLoggedDriverInfoSuccessState(driver: driver));
  }
}
