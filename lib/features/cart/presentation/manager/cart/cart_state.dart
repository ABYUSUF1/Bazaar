part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<Product> cartList;
  final double subTotal;
  final double couponDiscount;
  final double totalPrice;

  CartSuccess(
      this.cartList, this.subTotal, this.couponDiscount, this.totalPrice);
}

class CartFailure extends CartState {
  final String error;

  CartFailure(this.error);
}
