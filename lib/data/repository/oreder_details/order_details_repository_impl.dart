import 'package:flowery_driver/core/api/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entity/order_details/update_order_entity.dart';
import '../../../domain/repository/order_details/order_details_repository.dart';
import '../../data_source/remote_data_source/order_details/order_details_remote_data_source.dart';
import '../../model/order/UpdateOrderDetailsRequestBody.dart';

@Injectable(as: OrderDetailsRepository)
class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsRemoteDataSource _remoteDataSource;

  OrderDetailsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<UpdateOrdersEntity?>> updateOrderState(String orderId, UpdateOrderDetailsRequestBody state) async {
   final response= await _remoteDataSource.updateOrderState(orderId, state);
   switch (response) {
     case Success():
       final data = response.data?.toEntity();
       return Success(data: data);
     case Fail():
       return Fail(exception: response.exception);
   }
  }
  @override
  Future<Result<UpdateOrdersEntity?>> startOrder(String orderId) async {
    final response= await _remoteDataSource.startOrder(orderId);
    switch (response) {
      case Success():
        final data = response.data?.toEntity();
        return Success(data: data);
      case Fail():
        return Fail(exception: response.exception);  }
}}