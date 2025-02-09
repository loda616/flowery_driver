import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/model/auth/requests/apply_request_model.dart';
import '../../entity/auth/applu.dart';
import '../../repository/auth/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _repo;

  SignUpUseCase(this._repo);

  Future<Result<String?>> invoke(ApplyRequestEntity userData) async {
    return await _repo.apply(userData);
  }
}
