import 'dart:io';

import 'package:flowery_driver/data/model/auth/requests/edite_profile_request_model.dart';
import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/repository/profile/profile_repository.dart';
import '../../data_source/remote_data_source/profile/profile_remote_data_source.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Result<DriverEntity?>> getLoggedDriverInfo() async {
    final result = await profileRemoteDataSource.getLoggedDriverInfo();
    switch (result) {
      case Success():
        final data = result.data?.toEntity();
        return Success(data: data);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<String?>> logout() async {
    return await profileRemoteDataSource.logout();
  }

  @override
  Future<Result<VehicleEntity?>> getVehicleInfo(String vehicleId) async {
    final result = await profileRemoteDataSource.getVehicleInfo(vehicleId);
    switch (result) {
      case Success():
        final data = result.data?.toEntity();
        return Success(data: data);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<DriverEntity?>> editeProfile( Map<String, dynamic> body) {
    return profileRemoteDataSource.editProfile(body);
  }

  @override
  Future<Result<String?>> uploadPhoto(File photo) {
    return profileRemoteDataSource.uploadPhoto(photo);
  }

  @override
  Future<Result<List<VehicleEntity?>>> getAllVehicle() async {
    final result = await profileRemoteDataSource.getAllVehicles();
    switch (result) {
      case Success():
        final data =result.data?.map((model) => model?.toEntity()).toList();
        return Success(data: data);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
