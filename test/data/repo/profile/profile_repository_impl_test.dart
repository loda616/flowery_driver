import 'package:flowery_driver/core/api/api_result.dart';
import 'package:flowery_driver/data/data_source/remote_data_source/order_details/order_details_remote_data_source.dart';
import 'package:flowery_driver/data/model/order/UpdateOrderDetailsRequestBody.dart';
import 'package:flowery_driver/data/model/order/update_order_model.dart';
import 'package:flowery_driver/data/repository/oreder_details/order_details_repository_impl.dart';
import 'package:flowery_driver/domain/entity/order_details/update_order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([OrderDetailsRemoteDataSource, UpdateOrdersModel])
void main() {
  late MockOrderDetailsRemoteDataSource mockRemoteDataSource;
  late MockUpdateOrdersModel mockModel;
  late OrderDetailsRepositoryImpl repository;

  setUpAll(() {
    provideDummy<Result<UpdateOrdersModel?>>(
      Fail(exception: Exception('dummy exception')),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockOrderDetailsRemoteDataSource();
    mockModel = MockUpdateOrdersModel();
    repository = OrderDetailsRepositoryImpl(mockRemoteDataSource);
  });

  const dummyOrderId = '12345';
  const dummyState = 'delivered';

  final dummyRequestBody = UpdateOrderDetailsRequestBody(state: dummyState);
  final dummyEntity = UpdateOrdersEntity(id: dummyOrderId, state: dummyState);

  group('OrderDetailsRepositoryImpl', () {
    test(' updateOrderState returns Success', () async {
      when(mockModel.toEntity()).thenReturn(dummyEntity);
      when(mockRemoteDataSource.updateOrderState(
              dummyOrderId, dummyRequestBody))
          .thenAnswer((_) async => Success(data: mockModel));

      final result =
          await repository.updateOrderState(dummyOrderId, dummyRequestBody);

      expect(result, isA<Success<UpdateOrdersEntity?>>());
      expect((result as Success).data?.id, dummyEntity.id);
      verify(mockRemoteDataSource.updateOrderState(
              dummyOrderId, dummyRequestBody))
          .called(1);
      verify(mockModel.toEntity()).called(1);
    });

    test(' startOrder returns Success', () async {
      when(mockModel.toEntity()).thenReturn(dummyEntity);
      when(mockRemoteDataSource.startOrder(dummyOrderId))
          .thenAnswer((_) async => Success(data: mockModel));

      final result = await repository.startOrder(dummyOrderId);

      expect(result, isA<Success<UpdateOrdersEntity?>>());
      expect((result as Success).data?.state, dummyEntity.state);
      verify(mockRemoteDataSource.startOrder(dummyOrderId)).called(1);
      verify(mockModel.toEntity()).called(1);
    });
  });
}
