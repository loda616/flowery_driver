import 'package:flowery_driver/domain/entity/vehicles/vehicle_type_entity.dart';

import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/entity/profile/vehicle_entity.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

//GetLoggedDriverInfoStates
class GetLoggedDriverInfoLoadingState extends ProfileState {}

class GetLoggedDriverInfoSuccessState extends ProfileState {
  final DriverEntity? driver;

  GetLoggedDriverInfoSuccessState({ this.driver});
}

class GetLoggedDriverInfoErrorState extends ProfileState {
  final String? errorMessage;
  GetLoggedDriverInfoErrorState({this.errorMessage});
}

//GetVehicleInfoStates
class GetVehicleInfoLoadingState extends ProfileState {}

class GetVehicleInfoSuccessState extends ProfileState {
  final VehicleEntity? vehicle;

  GetVehicleInfoSuccessState({
    this.vehicle,
  });
}

class GetVehicleInfoErrorState extends ProfileState {
  final String? errorMessage;
  GetVehicleInfoErrorState({this.errorMessage});
}

//LogoutStates
class LogoutSuccessState extends ProfileState {
  String? message;
  LogoutSuccessState(this.message);
}

class LogoutErrorState extends ProfileState {
  String? message;
  LogoutErrorState(this.message);
}

//Edit profile
class EditProfileLoadingState extends ProfileState {}

class EditProfileSuccessState extends ProfileState {
  final DriverEntity? driver;

  EditProfileSuccessState({this.driver});
}

class EditProfileErrorState extends ProfileState {
  final String? errorMessage;

  EditProfileErrorState({this.errorMessage});
}

//Upload photo
class UploadPhotoLoadingState extends ProfileState {}

class UploadPhotoSuccessState extends ProfileState {
  final String? message;

  UploadPhotoSuccessState({this.message});
}

class UploadPhotoErrorState extends ProfileState {
  final String? errorMessage;

  UploadPhotoErrorState({this.errorMessage});
}
final class GetVehiclesTypeLoading extends ProfileState {}

final class GetVehiclesTypeSuccess extends ProfileState {}

final class GetVehiclesTypesError extends ProfileState {
  final String? errorMessage;

  GetVehiclesTypesError({this.errorMessage});
}