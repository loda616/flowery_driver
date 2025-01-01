part of 'apply_view_model.dart';

sealed class ApplyState {}

final class ApplyInitial extends ApplyState {}

final class ApplyLoading extends ApplyState {}

final class ApplySuccess extends ApplyState {
  final String? message;

  ApplySuccess(this.message);
}

final class ApplyFail extends ApplyState {
  final String? errorMassage;

  ApplyFail(this.errorMassage);
}

final class GetVehiclesTypesLoading extends ApplyState {}

final class GetVehiclesTypesSuccess extends ApplyState {}

final class GetVehiclesTypesFail extends ApplyState {
  final String? errorMassage;

  GetVehiclesTypesFail(this.errorMassage);
}
