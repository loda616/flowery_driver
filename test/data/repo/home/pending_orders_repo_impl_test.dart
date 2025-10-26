import 'package:flowery_driver/core/api/api_result.dart';
import 'package:flowery_driver/data/data_source/remote_data_source/home/pending_orders_data_source.dart';
import 'package:flowery_driver/data/model/pending_orders/order_model.dart';
import 'package:flowery_driver/data/repository/home/pending_orders_repo_impl.dart';
import 'package:flowery_driver/domain/entity/pending_orders/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'pending_orders_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late PendingOrderRepositoryImpl repository;

  provideDummy<Result<List<OrderModel?>>>(Success(data: []));
  provideDummy<Result<List<OrderModel?>>>(Fail(exception: Exception('dummy')));

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = PendingOrderRepositoryImpl(mockRemoteDataSource);
  });

  group('PendingOrderRepositoryImpl Tests', () {
    test('should return list of OrderEntity when successful', () async {
      final pendingOrders = [
        OrderModel(id: '10'),
      ];

      when(mockRemoteDataSource.getPendingOrders())
          .thenAnswer((_) async => Success(data: pendingOrders));

      final result = await repository.getPendingOrders();

      expect(result, isA<Success<List<OrderEntity?>>>());
      final successResult = result as Success<List<OrderEntity?>>;
      expect(successResult.data?.first?.id, '10');
    });

    test('should return Fail when remote call fails', () async {
      final exception = Exception('Network error');

      when(mockRemoteDataSource.getPendingOrders())
          .thenAnswer((_) async => Fail(exception: exception));

      final result = await repository.getPendingOrders();

      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });
}
