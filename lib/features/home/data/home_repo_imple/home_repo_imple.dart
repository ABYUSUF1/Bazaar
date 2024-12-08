import 'package:bazaar/core/api/api_client.dart';
import 'package:bazaar/core/utils/errors/failure.dart';
import 'package:bazaar/features/home/data/models/home_get_all_categories_model/home_categories_model.dart';
import 'package:bazaar/features/home/domain/entities/home_categories_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/entities/products_details_entity.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../../../core/utils/models/products_details_model/products_details_model.dart';
import '../../domain/home_repo/home_repo.dart';

class HomeRepoImple implements HomeRepo {
  final ApiClient _apiClient;
  HomeRepoImple(this._apiClient);

  @override
  Future<Either<Failure, List<HomeCategoriesEntity>>> getAllCategories() async {
    try {
      final response = await _apiClient.get(EndPoints.categories);

      List<HomeGetAllCategoriesModel> models = (response.data as List)
          .map((json) => HomeGetAllCategoriesModel.fromJson(json))
          .toList();

      List<HomeCategoriesEntity> entities =
          models.map((model) => model.toEntity()).toList();

      return right(entities);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductsDetailsEntity>>>
      getPopularProducts() async {
    try {
      final response = await _apiClient.get(EndPoints.popularProducts);

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
  Future<Either<Failure, List<ProductsDetailsEntity>>> getCategoryProducts(
      {required String categorySlug}) async {
    try {
      final response =
          await _apiClient.get(EndPoints.categoryProducts(categorySlug));

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
}
