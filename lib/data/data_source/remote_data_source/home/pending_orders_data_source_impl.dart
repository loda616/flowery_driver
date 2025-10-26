import 'package:flowery_driver/data/data_source/remote_data_source/home/pending_orders_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/home_api/home_api_manager.dart';
import '../../../model/pending_orders/order_model.dart';

@Injectable(as: HomeRemoteDataSource)
class ProfileRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeApiManager apiManger;
  ProfileRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<List<OrderModel?>>> getPendingOrders() async {
    return await executeApiCall<List<OrderModel?>>(() async {
      var token = await _getToken();
      var orderModel = await apiManger.getPendingOrders(token);
      return orderModel.orders??[];
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
