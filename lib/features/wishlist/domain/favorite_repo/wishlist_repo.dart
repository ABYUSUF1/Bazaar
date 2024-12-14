import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/models/products_details_model/product.dart';

abstract class WishlistRepo {
  Future<Either<Failure, List<Product>>> fetchWishlist();
  Future<Either<Failure, void>> addToWishlist(Product product);
  Future<Either<Failure, void>> removeFromWishlist(String productId);
}
