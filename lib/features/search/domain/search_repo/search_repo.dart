import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';

abstract class SearchRepo {
  /// Search products by a query string.
  /// If the query is `null` or empty, it may return recent searches or an empty list.
  Future<Either<Failure, List<ProductsDetailsEntity>>> searchProducts(
      String? query);

  /// Retrieve a list of recent searches.
  Future<Either<Failure, List<String>>> getRecentSearches();

  /// Add a search term to the recent searches.
  Future<Either<Failure, void>> addRecentSearch(String query);

  /// Remove a specific search term from recent searches.
  Future<Either<Failure, void>> removeRecentSearch(String query);

  /// Clear all recent searches.
  Future<Either<Failure, void>> clearRecentSearches();
}
