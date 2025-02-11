import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/driver_orders_api/driver_orders_api_manager.dart';
import '../../../model/driver_orders/driver_order_model.dart';
import 'driver_orders_data_source.dart';

@Injectable(as: DriverOrdersRemoteDataSource)
class DriverOrdersRemoteDataSourceImpl implements DriverOrdersRemoteDataSource {
  final DriverOrdersApiManager apiManager;

  DriverOrdersRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Result<List<DriverOrderModel?>>> getDriverOrders() async {
    return await executeApiCall<List<DriverOrderModel?>>(() async {
      var token = await _getToken();
      var response = await apiManager.getDriverOrders(token);
      return response.orders ?? [];
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