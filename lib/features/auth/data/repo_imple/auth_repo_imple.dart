import 'package:bazaar/core/services/firebase/firestore_service.dart';
import 'package:bazaar/features/auth/data/models/auth_model.dart';
import 'package:bazaar/features/auth/domain/entities/auth_entity.dart';
import 'package:bazaar/features/profile/domain/repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../core/utils/errors/auth_failure.dart';
import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../domain/repo/auth_repo.dart';

class AuthRepoImple implements AuthRepo {
  final FirebaseAuthService _firebaseAuthService;
  final AuthFirestoreService _userFirestoreService;
  final ProfileRepo profileRepo;

  AuthRepoImple(
      this._firebaseAuthService, this._userFirestoreService, this.profileRepo);

  @override
  Future<Either<Failure, AuthEntity>> createNewAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _executeAuthOperation(() async {
      final User user = await _firebaseAuthService
          .createUserWithEmailAndPassword(email: email, password: password);

      final AuthModel authModel = AuthModel.fromFirebaseUser(user);
      final AuthEntity authEntity = authModel.toEntity();
      await profileRepo.saveUserData(authEntity);
      return authEntity;
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _executeAuthOperation(() async {
      final User user = await _firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthModel.fromFirebaseUser(user).toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> signInWithGoogle() async {
    return _executeAuthOperation(() async {
      final User user = await _firebaseAuthService.signInWithGoogle();

      // Check if user data exists in Firestore
      final bool exists = await _userFirestoreService.isDocumentExists(
        user.uid,
      );

      if (!exists) {
        final AuthModel authModel = AuthModel.fromFirebaseUser(user);
        await profileRepo.saveUserData(authModel.toEntity());
      }

      return AuthModel.fromFirebaseUser(user).toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> signInWithFacebook() async {
    // Implementation placeholder for Facebook login
    return left(ServerFailure('Facebook login not implemented.'));
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    return _executeAuthOperation(() async {
      await _firebaseAuthService.sendPasswordResetEmail(email);
    });
  }

  @override
  Future<Either<Failure, void>> verifyEmail() async {
    return _executeAuthOperation(() async {
      await _firebaseAuthService.verifyEmail();
    });
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return _executeAuthOperation(() async {
      await _firebaseAuthService.signOut();
    });
  }

  /// Handles success or failure of an auth operation
  Future<Either<Failure, T>> _executeAuthOperation<T>(
      Future<T> Function() authMethod) async {
    try {
      final result = await authMethod();
      return right(result);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
