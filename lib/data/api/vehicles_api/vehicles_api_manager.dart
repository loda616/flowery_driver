import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../model/vehicles/vehicle_types_response_model.dart';

part 'vehicles_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VehiclesApiManager {
  @factoryMethod
  factory VehiclesApiManager(Dio dio) = _VehiclesApiManager;

  @POST(ApiConstants.getAllVehiclesType)
  Future<VehicleTypesResponseModel> getAllVehiclesType();
}
