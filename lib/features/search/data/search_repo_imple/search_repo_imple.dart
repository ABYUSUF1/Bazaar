import 'package:bazaar/core/api/end_points.dart';
import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:bazaar/features/search/domain/search_repo/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../../../core/utils/models/products_details_model/products_details_model.dart';

class SearchRepoImple implements SearchRepo {
  final ApiClient _apiClient;

  SearchRepoImple(this._apiClient);

  // we will use shared pref or hive in future ...
  final List<String> _recentSearches = [];

  @override
  Future<Either<Failure, List<ProductsDetailsEntity>>> searchProducts(
      String? query) async {
    try {
      final response = await _apiClient.get(EndPoints.searchProducts(query));
      final model =
          ProductsDetailsModel.fromJson(response.data as Map<String, dynamic>);

      // Validate response data
      if (model.products == null) {
        return Left(ServerFailure('Products not found in response.'));
      }

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
      return Right(List.unmodifiable(_recentSearches));
    } catch (e) {
      return const Left(
          Failure('An error occurred while fetching recent searches.'));
    }
  }

  @override
  Future<Either<Failure, void>> addRecentSearch(String query) async {
    try {
      if (!_recentSearches.contains(query)) {
        _recentSearches.add(query);
      }
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure('An error occurred while adding the recent search.'));
    }
  }

  @override
  Future<Either<Failure, void>> removeRecentSearch(String query) async {
    try {
      _recentSearches.remove(query);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure('An error occurred while removing the recent search.'));
    }
  }

  @override
  Future<Either<Failure, void>> clearRecentSearches() async {
    try {
      _recentSearches.clear();
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure('An error occurred while clearing recent searches.'));
    }
  }
}
