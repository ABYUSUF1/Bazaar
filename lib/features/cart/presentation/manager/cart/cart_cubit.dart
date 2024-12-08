import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial()) {
    getCartItems();
  }
  final CartRepo cartRepo;
  final TextEditingController couponController = TextEditingController();
  List<Product> cartList = [];

  /// Used to make animation when user just tap on "Add To Cart" button
  bool isJustAddedToCart = false;

  // Price tracking
  double subTotal = 0.0;
  double discount = 0.0;
  double totalPrice = 0.0;

  // Fetch cart items
  Future<void> getCartItems() async {
    emit(CartLoading());
    final result = await cartRepo.getCartItems();
    result.fold(
      (failure) => emit(CartFailure(failure.errMessage)),
      (cart) {
        cartList = cart;

        _updatePrices();
        emit(CartSuccess(cartList, subTotal, discount, totalPrice));
      },
    );
  }

  // Add a product to the cart
  Future<void> addToCart(Product product) async {
    emit(CartLoading());
    cartList.add(product);

    _updatePrices();
    isJustAddedToCart = true;
    emit(CartSuccess(cartList, subTotal, discount, totalPrice));

    try {
      final result = await cartRepo.addCartItem(product);
      result.fold(
        (failure) => emit(CartFailure(failure.errMessage)),
        (_) => {},
      );
    } catch (e) {
      cartList.removeWhere((item) => item.id == product.id);

      _updatePrices();
      emit(CartFailure('Error adding item to cart: $e'));
      emit(CartSuccess(cartList, subTotal, discount, totalPrice));
    }
  }

  // Remove a product from the cart
  Future<void> removeFromCart(Product product) async {
    emit(CartLoading());
    cartList.removeWhere((item) => item.id == product.id);

    _updatePrices();
    emit(CartSuccess(cartList, subTotal, discount, totalPrice));

    try {
      final result = await cartRepo.removeCartItem(product);
      result.fold(
        (failure) => emit(CartFailure(failure.errMessage)),
        (_) => {},
      );
    } catch (e) {
      cartList.add(product);

      _updatePrices();
      emit(CartFailure('Error removing item from cart: $e'));
      emit(CartSuccess(cartList, subTotal, discount, totalPrice));
    }
  }

  // Update product quantity
  void updateQuantity(Product product, int newQuantity) {
    product.quantity = newQuantity;
    _updatePrices();
    emit(CartSuccess(cartList, subTotal, discount, totalPrice));
    cartRepo.updateCartItemQuantity(product, newQuantity);
  }

  // Apply coupon discount
  void applyCoupon() {
    discount = cartRepo.addCouponDiscount(couponController.text.trim());
    _updatePrices();
    emit(CartSuccess(cartList, subTotal, discount, totalPrice));
  }

  // Update prices
  void _updatePrices() {
    subTotal = cartRepo.calculateSubTotal(cartList.toSet());
    totalPrice = cartRepo.calculateTotalPrice(subTotal, discount);
  }

  // Dispose of resources
  @override
  Future<void> close() {
    couponController.dispose();
    return super.close();
  }
}
