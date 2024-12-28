part of 'apply_view_model.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final String? message;

  SignUpSuccess(this.message);
}

final class SignUpFail extends SignUpState {
  final String? errorMassage;

  SignUpFail(this.errorMassage);
}

final class GetVehiclesTypesLoading extends SignUpState {}

final class GetVehiclesTypesSuccess extends SignUpState {}

final class GetVehiclesTypesFail extends SignUpState {
  final String? errorMassage;

  GetVehiclesTypesFail(this.errorMassage);
}
