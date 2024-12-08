import 'package:dartz/dartz.dart';

import '../../../../core/utils/entities/products_details_entity.dart';
import '../../../../core/utils/errors/failure.dart';

abstract class ProductRepo {
  Future<Either<Failure, ProductsDetailsEntity>> getProduct(
      {required String productId});
}
