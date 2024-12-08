import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/errors/failure.dart';

abstract class CartRepo {
  Future<Either<Failure, List<Product>>> getCartItems();
  Future<Either<Failure, void>> addCartItem(Product product);
  Future<Either<Failure, void>> removeCartItem(Product product);
  Future<Either<Failure, void>> updateCartItemQuantity(
      Product product, int newQuantity);

  double calculateTotalPrice(double subTotal, double couponDiscount);
  double calculateSubTotal(Set<Product> cartProducts);
  double addCouponDiscount(String couponCode);
}
