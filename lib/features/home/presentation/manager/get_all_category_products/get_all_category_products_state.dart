part of 'get_all_category_products_cubit.dart';

sealed class GetAllCategoryProductsState {}

class GetAllCategoryProductsInitial extends GetAllCategoryProductsState {}

class GetAllCategoryProductsLoading extends GetAllCategoryProductsState {}

class GetAllCategoryProductsFailure extends GetAllCategoryProductsState {
  final String errMessage;

  GetAllCategoryProductsFailure({required this.errMessage});
}

class GetAllCategoryProductsSuccess extends GetAllCategoryProductsState {
  final List<ProductsDetailsEntity> categoryProductsList;
  final int filteredProductCount;
  final String sortCriteria;
  final int productDisplayLimit;

  GetAllCategoryProductsSuccess({
    required this.categoryProductsList,
    required this.filteredProductCount,
    required this.sortCriteria,
    required this.productDisplayLimit,
  });
}
