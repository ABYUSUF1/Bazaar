import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../auth/domain/entities/auth_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> saveUserData(AuthEntity authEntity);

  Future<Either<Failure, AuthEntity>> getUserData(String uid);

  Future<Either<Failure, void>> updateUserData({
    String? username,
    String? phoneNumber,
    String? birthday,
    String? profileImage,
    required String userId,
  });
}
