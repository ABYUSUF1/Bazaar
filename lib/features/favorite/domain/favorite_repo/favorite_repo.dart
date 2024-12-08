import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/models/products_details_model/product.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, List<Product>>> fetchFavorites();
  Future<Either<Failure, void>> addFavorite(Product product);
  Future<Either<Failure, void>> removeFavorite(String productId);
}
