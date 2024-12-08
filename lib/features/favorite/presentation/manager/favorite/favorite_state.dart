import '../../../../../core/utils/models/products_details_model/product.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Product> favoriteProducts;

  FavoriteSuccess(this.favoriteProducts);
}

class FavoriteFailure extends FavoriteState {
  final String errMessage;

  FavoriteFailure(this.errMessage);
}
