import 'package:flowery_driver/domain/entity/profile/driver_entity.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

//GetLoggedDriverInfo
class GetLoggedDriverInfoLoadingState extends ProfileState {}

class GetLoggedDriverInfoSuccessState extends ProfileState {
  final DriverEntity? driver;
  GetLoggedDriverInfoSuccessState({this.driver});
}

class GetLoggedDriverInfoErrorState extends ProfileState {
  final String? errorMessage;
  GetLoggedDriverInfoErrorState({this.errorMessage});
}

