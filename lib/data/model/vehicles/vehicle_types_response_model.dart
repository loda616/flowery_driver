import '../metadata_model.dart';
import 'vehicle_type_model.dart';

final class VehicleTypesResponseModel {
  final String? message;
  final MetadataModel? metadata;

  final List<VehicleTypeModel>? data;

  VehicleTypesResponseModel({
    this.message,
    this.metadata,
    this.data,
  });

  factory VehicleTypesResponseModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypesResponseModel(
      message: json['message'],
      metadata: MetadataModel.fromJson(json['metadata']),
      data: List<VehicleTypeModel>.from(
          json['vehicles'].map((x) => VehicleTypeModel.fromJson(x))),
    );
  }
}
