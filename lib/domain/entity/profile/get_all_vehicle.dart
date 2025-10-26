import 'package:flowery_driver/domain/entity/profile/vehicle_entity.dart';
import '../pending_orders/meta_data.dart';

class GetAllVehicle {
  GetAllVehicle({
      this.message, 
      this.metadata, 
      this.vehicles,});

  String? message;
  Metadata? metadata;
  List<VehicleEntity>? vehicles;


}