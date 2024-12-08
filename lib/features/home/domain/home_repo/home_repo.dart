import 'package:dartz/dartz.dart';

import '../../../../core/utils/entities/products_details_entity.dart';
import '../../../../core/utils/errors/failure.dart';
import '../entities/home_categories_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<HomeCategoriesEntity>>> getAllCategories();

  Future<Either<Failure, List<ProductsDetailsEntity>>> getPopularProducts();

  Future<Either<Failure, List<ProductsDetailsEntity>>> getCategoryProducts(
      {required String categorySlug});
}
