import 'dart:io';

import 'package:flowery_driver/core/api/execute_api_call.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/order_details/order_details_api_manager.dart';
import '../../../model/order/UpdateOrderDetailsRequestBody.dart';
import '../../../model/order/update_order_model.dart';
import 'order_details_remote_data_source.dart';

@Injectable(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  final OrderDetailsApiManager _apiManager;

  OrderDetailsRemoteDataSourceImpl(this._apiManager);

  @override
  Future<Result<UpdateOrdersModel?>> updateOrderState(
      String orderId, UpdateOrderDetailsRequestBody state) async {
    return await executeApiCall<UpdateOrdersModel?>(() async {
      var token = await _getToken();

      var updateOrder =
          await _apiManager.updateOrderState(orderId, state, token);
      return updateOrder!.orders;
    });
  }

  @override
  Future<Result<UpdateOrdersModel?>> startOrder(String orderId) async {
    return await executeApiCall<UpdateOrdersModel?>(() async {
      var token = await _getToken();
      var updateOrder = await _apiManager.startOrder(orderId, token);
      return updateOrder!.orders;
    });
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
