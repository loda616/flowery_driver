import 'package:flowery_driver/core/api/api_result.dart';
import 'package:flowery_driver/data/data_source/remote_data_source/vehicles/vehicles_remote_data_source.dart';
import 'package:flowery_driver/data/model/vehicles/vehicle_type_model.dart';
import 'package:flowery_driver/data/model/vehicles/vehicle_types_response_model.dart';
import 'package:flowery_driver/data/repository/vehicles/vehicles_repository_impl.dart';
import 'package:flowery_driver/domain/entity/vehicles/vehicle_type_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicles_repository_impl_test.mocks.dart';

@GenerateMocks([VehiclesRemoteDataSource])
void main() {
  late MockVehiclesRemoteDataSource mockRemoteDataSource;
  late VehiclesRepositoryImpl repository;

  setUpAll(() {
    provideDummy<Result<VehicleTypesResponseModel?>>(
      Fail(exception: Exception('dummy exception')),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockVehiclesRemoteDataSource();
    repository = VehiclesRepositoryImpl(mockRemoteDataSource);
  });

  group('VehiclesRepositoryImpl - getAllVehiclesType', () {
    test(' returns Success when remoteDataSource succeeds', () async {
      final dummyEntity = VehicleType(id: '1', type: 'Truck');
      final dummyModel = VehicleTypeModel(id: '1', type: 'Truck');
      final dummyResponseModel = VehicleTypesResponseModel(data: [dummyModel]);

      when(mockRemoteDataSource.getAllVehiclesType())
          .thenAnswer((_) async => Success(data: dummyResponseModel));

      final result = await repository.getAllVehiclesType();

      expect(result, isA<Success<List<VehicleType>?>>());
      final success = result as Success<List<VehicleType>?>;
      expect(success.data?.first.type, dummyEntity.type);
      expect(success.data?.first.id, dummyEntity.id);
      verify(mockRemoteDataSource.getAllVehiclesType()).called(1);
    });

    test('returns Fail when remoteDataSource fails', () async {
      final exception = Exception('Network error');
      when(mockRemoteDataSource.getAllVehiclesType())
          .thenAnswer((_) async => Fail(exception: exception));

      final result = await repository.getAllVehiclesType();

      expect(result, isA<Fail>());
      expect((result as Fail).exception, exception);
      verify(mockRemoteDataSource.getAllVehiclesType()).called(1);
    });
  });
}
