import 'package:bazaar/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthEntity>> createNewAccountWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthEntity>> signInWithGoogle();

  Future<Either<Failure, AuthEntity>> signInWithFacebook(); // Future feature

  Future<Either<Failure, void>> forgetPassword(String email);

  Future<Either<Failure, void>> verifyEmail();

  Future<Either<Failure, void>> signOut();
}
