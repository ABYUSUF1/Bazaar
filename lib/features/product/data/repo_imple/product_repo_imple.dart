import 'package:bazaar/core/utils/entities/products_details_entity.dart';

import 'package:bazaar/core/utils/errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/errors/server_failure.dart';
import '../../../../core/utils/models/products_details_model/products_details_model.dart';
import '../../domain/repo/product_repo.dart';

class ProductRepoImple implements ProductRepo {
  final ApiClient _apiClient;
  ProductRepoImple(this._apiClient);

  @override
  Future<Either<Failure, ProductsDetailsEntity>> getProduct(
      {required String productId}) async {
    try {
      final response =
          await _apiClient.get(EndPoints.getProductById(productId));

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

      return right(entities.first);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
