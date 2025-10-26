import 'package:flowery_driver/core/api/api_result.dart';
import 'package:flowery_driver/data/data_source/remote_data_source/driver_orders/driver_orders_data_source.dart';
import 'package:flowery_driver/data/model/driver_orders/driver_order_model.dart';
import 'package:flowery_driver/data/repository/driver_orders/driver_orders_repository_impl.dart';
import 'package:flowery_driver/domain/entity/drivers_order/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'driver_orders_repository_impl_test.mocks.dart';

@GenerateMocks([DriverOrdersRemoteDataSource])
void main() {
  late MockDriverOrdersRemoteDataSource mockRemoteDataSource;
  late DriverOrdersRepositoryImpl repository;

  provideDummy<Result<List<DriverOrderModel?>>>(Success(data: []));
  provideDummy<Result<List<DriverOrderModel?>>>(
      Fail(exception: Exception('dummy')));

  setUp(() {
    mockRemoteDataSource = MockDriverOrdersRemoteDataSource();
    repository = DriverOrdersRepositoryImpl(mockRemoteDataSource);
  });

  group('DriverOrdersRepositoryImpl Tests', () {
    test('returns list of orders (OrderEntity) when successful', () async {
      final driverOrders = [
        DriverOrderModel(id: '1'),
      ];

      when(mockRemoteDataSource.getDriverOrders())
          .thenAnswer((_) async => Success(data: driverOrders));

      final result = await repository.getDriverOrders();

      expect(result, isA<Success<List<OrderEntity?>>>());
      final successResult = result as Success<List<OrderEntity?>>;
      expect(successResult.data?.first?.id, '1');
    });

    test('returns failure when remote call fails', () async {
      final exception = Exception('Network error');

      when(mockRemoteDataSource.getDriverOrders())
          .thenAnswer((_) async => Fail(exception: exception));

      final result = await repository.getDriverOrders();

      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });
}
