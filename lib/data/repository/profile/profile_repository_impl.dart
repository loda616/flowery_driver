import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entity/profile/driver_entity.dart';
import '../../../domain/repository/profile/profile_repository.dart';
import '../../data_source/remote_data_source/profile/profile_remote_data_source.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Result<DriverEntity?>> getLoggedDriverInfo() async {
    final result = await profileRemoteDataSource.getLoggedDriverInfo();
    switch (result) {
      case Success():
        final data = result.data?.toEntity();
        return Success(data: data);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
