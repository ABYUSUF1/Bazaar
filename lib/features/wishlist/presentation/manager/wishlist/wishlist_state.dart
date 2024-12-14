import '../../../../../core/utils/models/products_details_model/product.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<Product> wishlistProducts;

  WishlistSuccess(this.wishlistProducts);
}

class WishlistFailure extends WishlistState {
  final String errMessage;

  WishlistFailure(this.errMessage);
}
