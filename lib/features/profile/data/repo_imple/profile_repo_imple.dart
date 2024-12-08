import 'package:bazaar/core/services/firebase/firestore_service.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repo/profile_repo.dart';
import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../auth/domain/entities/auth_entity.dart';

class ProfileRepoImple extends ProfileRepo {
  final AuthFirestoreService _authFirestoreService;

  ProfileRepoImple(this._authFirestoreService);

  @override
  Future<Either<Failure, void>> saveUserData(AuthEntity authEntity) async {
    try {
      final authModel = AuthModel.fromEntity(authEntity);
      await _authFirestoreService.setDocument(
        authModel.id!,
        authModel.toMap(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to save user data: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData({
    String? username,
    String? phoneNumber,
    String? birthday,
    String? profileImage,
    required String userId,
  }) async {
    try {
      final Map<String, dynamic> updates = {};

      if (username != null) updates['username'] = username;
      if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;
      if (birthday != null) updates['birthday'] = birthday;
      if (profileImage != null) updates['profileImage'] = profileImage;

      if (updates.isNotEmpty) {
        await _authFirestoreService.updateDocument(
          userId,
          updates,
        );
        return const Right(null); // Return success (void)
      } else {
        return Left(ServerFailure('No data to update.'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to update user data: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserData(String uid) async {
    try {
      final doc = await _authFirestoreService.getDocument(uid);

      if (!doc.exists) {
        return Left(ServerFailure('User data not found.'));
      }

      final authModel = AuthModel.fromMap(doc.data()!);
      return Right(authModel.toEntity());
    } catch (e) {
      return Left(ServerFailure('Failed to get user data: $e'));
    }
  }
}
