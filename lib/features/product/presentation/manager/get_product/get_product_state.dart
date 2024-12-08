part of 'get_product_cubit.dart';

@immutable
sealed class GetProductState {}

final class GetProductInitial extends GetProductState {}

final class GetProductLoading extends GetProductState {}

final class GetProductSuccess extends GetProductState {
  final ProductsDetailsEntity productsDetailsEntity;
  GetProductSuccess({required this.productsDetailsEntity});
}

final class GetProductFailure extends GetProductState {
  final String errMessage;
  GetProductFailure({required this.errMessage});
}
