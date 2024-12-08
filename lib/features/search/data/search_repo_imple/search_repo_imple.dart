import 'package:bazaar/core/api/end_points.dart';
import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:bazaar/features/search/domain/search_repo/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../../../core/utils/models/products_details_model/products_details_model.dart';

class SearchRepoImple implements SearchRepo {
  final ApiClient _apiClient;

  static const String _recentSearchesKey = 'recent_searches';

  SearchRepoImple(this._apiClient);

  @override
  Future<Either<Failure, List<ProductsDetailsEntity>>> searchProducts(
      String? query) async {
    try {
      final response = await _apiClient.get(EndPoints.searchProducts(query));

      final model =
          ProductsDetailsModel.fromJson(response.data as Map<String, dynamic>);

      // Create a list of entities from the products
      List<ProductsDetailsEntity> entities = model.products?.map((product) {
            return ProductsDetailsEntity(
              products: [
                product
              ], // Here you create a new entity for each product
              total: model.total,
              skip: model.skip,
              limit: model.limit,
            );
          }).toList() ??
          [];

      return right(entities);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final searches = prefs.getStringList(_recentSearchesKey) ?? [];
      return right(searches);
    } catch (e) {
      return left(ServerFailure('Failed to retrieve recent searches.'));
    }
  }

  @override
  Future<Either<Failure, void>> addRecentSearch(String query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final searches = prefs.getStringList(_recentSearchesKey) ?? [];

      // Remove the query if it already exists to avoid duplication
      searches.remove(query);
      searches.insert(0, query); // Add the query at the top

      // Keep only the most recent 5 searches
      if (searches.length > 5) {
        searches.removeRange(5, searches.length);
      }

      await prefs.setStringList(_recentSearchesKey, searches);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure('Failed to save the search term.'));
    }
  }

  @override
  Future<Either<Failure, void>> removeRecentSearch(String query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final searches = prefs.getStringList(_recentSearchesKey) ?? [];

      searches.remove(query);

      await prefs.setStringList(_recentSearchesKey, searches);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure('Failed to remove the search term.'));
    }
  }

  @override
  Future<Either<Failure, void>> clearRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recentSearchesKey);
      return const Right(null);
    } catch (e) {
      return left(ServerFailure('Failed to clear recent searches.'));
    }
  }
}
