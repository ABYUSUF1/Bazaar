import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ProductsDetailsEntity>>> searchProducts(
      String? query);

  Future<Either<Failure, List<String>>> getRecentSearches();

  Future<Either<Failure, void>> addRecentSearch(String query);

  Future<Either<Failure, void>> removeRecentSearch(String query);

  Future<Either<Failure, void>> clearRecentSearches();
}
