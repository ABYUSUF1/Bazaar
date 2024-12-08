import 'package:animate_do/animate_do.dart';
import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_assets.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;
  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartCubit>().cartList;
    bool isProductInCart = cartItems.any((item) => item.id == product.id);
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final bool isLoading = state is CartLoading;
        return InkWell(
          onTap: () {
            if (!isProductInCart) {
              context.read<CartCubit>().addToCart(product);
            }
          },
          child: !isProductInCart
              ? _addToCart(isLoading)
              : context.read<CartCubit>().isJustAddedToCart
                  ? ClipRRect(
                      child: SlideInDown(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease,
                          from: 50,
                          child: _alreadyInCart(isLoading)))
                  : _alreadyInCart(isLoading),
        );
      },
    );
  }

  Container _addToCart(bool isLoading) {
    return Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.primaryColor,
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 15,
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add To Cart",
                    style: AppTextStyles.style14Normal
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    AppAssets.imagesIconsCart,
                    width: 20,
                    height: 20,
                    color: AppColors.whiteColor,
                  ),
                ],
              ));
  }

  _alreadyInCart(bool isLoading) {
    return Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.foregroundColor2,
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 15,
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.imagesIconsCart,
                    width: 20,
                    height: 20,
                    color: AppColors.whiteColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Already in Cart",
                    style: AppTextStyles.style14Normal
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ],
              ));
  }
}
