import 'package:bazaar/core/services/firebase/firebase_auth_service.dart';
import 'package:bazaar/core/services/firebase/firestore_service.dart';
import 'package:bazaar/core/services/get_it_service.dart';
import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../domain/repo/cart_repo.dart';

class CartRepoImple extends CartRepo {
  final CartFirestoreService cartFirestoreService;
  CartRepoImple(this.cartFirestoreService);

  @override
  Future<Either<Failure, void>> addCartItem(Product product) async {
    try {
      final userId = getIt<FirebaseAuthService>().getUserId();
      final result = await cartFirestoreService.setDocument(
          userId, product.id.toString(), product.toJson());
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCartItems() async {
    try {
      final userId = getIt<FirebaseAuthService>().getUserId();
      final result = await cartFirestoreService.getCollection(userId);
      return Right(
          result.docs.map((doc) => Product.fromJson(doc.data())).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeCartItem(Product product) async {
    try {
      final userId = getIt<FirebaseAuthService>().getUserId();
      final result = await cartFirestoreService.deleteDocument(
          userId, product.id.toString());
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCartItemQuantity(
      Product product, int newQuantity) async {
    try {
      final userId = getIt<FirebaseAuthService>().getUserId();
      final productData = product.toJson()..['quantity'] = newQuantity;
      final result = await cartFirestoreService.setDocument(
          userId, product.id.toString(), productData);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  double addCouponDiscount(String couponCode) {
    // Implement discount logic here
    if (couponCode.length == 4) {
      return -25.0; // Example fixed discount if coupon is 4 characters long
    }
    return 0.0; // No discount for other coupon codes
  }

  @override
  double calculateSubTotal(Set<Product> cartProducts) {
    return cartProducts.fold(0.0, (total, product) {
      return total + (product.price! * (product.quantity ?? 1));
    });
  }

  @override
  double calculateTotalPrice(double subTotal, double couponDiscount) {
    return subTotal + couponDiscount; // Subtract coupon discount from subtotal
  }
}
