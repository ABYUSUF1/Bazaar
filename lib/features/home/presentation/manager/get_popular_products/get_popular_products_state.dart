part of 'get_popular_products_cubit.dart';

@immutable
sealed class GetPopularProductsState {}

final class GetPopularProductsInitial extends GetPopularProductsState {}

final class GetPopularProductsLoading extends GetPopularProductsState {}

final class GetPopularProductsSuccess extends GetPopularProductsState {
  final List<ProductsDetailsEntity> popularProductsList;
  GetPopularProductsSuccess({required this.popularProductsList});
}

final class GetPopularProductsFailure extends GetPopularProductsState {
  final String errMessage;
  GetPopularProductsFailure({required this.errMessage});
}
