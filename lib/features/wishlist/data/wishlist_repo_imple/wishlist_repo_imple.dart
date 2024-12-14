import 'package:bazaar/core/services/firebase/firebase_auth_service.dart';
import 'package:bazaar/core/services/firebase/firestore_service.dart';
import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/server_failure.dart';
import '../../domain/favorite_repo/wishlist_repo.dart';

class FavoriteRepoImple implements WishlistRepo {
  final WishlistFirestoreService _firestoreService;
  final FirebaseAuthService _firebaseAuthService;
  FavoriteRepoImple(this._firestoreService, this._firebaseAuthService);

  @override
  Future<Either<Failure, void>> addToWishlist(Product product) async {
    try {
      await _firestoreService.setDocument(
        _firebaseAuthService.getUserId(),
        product.id.toString(),
        product.toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> fetchWishlist() async {
    try {
      final snapshot = await _firestoreService
          .getCollection(_firebaseAuthService.getUserId());

      final result =
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(String productId) async {
    try {
      await _firestoreService.deleteDocument(
        _firebaseAuthService.getUserId(),
        productId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
