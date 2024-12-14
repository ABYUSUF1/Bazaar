import 'package:bazaar/core/widget/bazaar_drawer/drawer_settings_section.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';
import '../../../../../core/widget/delivery_info.dart';
import '../../../../../core/widget/wishlist_button.dart';
import '../../../../../core/widget/quantity_button.dart';
import '../../../../product/presentation/views/widgets/product_price_and_discount.dart';
import '../../manager/cart/cart_cubit.dart';

class CartProductsListBodyMobile extends StatelessWidget {
  final List<Product> cartProducts;
  const CartProductsListBodyMobile({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cartProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.goNamed(AppRouter.product, pathParameters: {
                            'productTitle': cartProducts[index].title!,
                            'productId': cartProducts[index].id!.toString()
                          });
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor2,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CachedNetworkImage(
                              imageUrl: cartProducts[index].images![0]!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartProducts[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.style16Bold,
                            ),
                            Text(
                                cartProducts[index].brand ??
                                    LocaleKeys.category_filters_no_brand.tr(),
                                style: AppTextStyles.style14W600
                                    .copyWith(color: AppColors.greyColor)),
                            const SizedBox(height: 5),

                            // Price and discount
                            ProductPriceAndDiscount(
                                product: cartProducts[index],
                                showDiscountPercentage: false,
                                priceStyle: AppTextStyles.style20Bold
                                    .copyWith(color: AppColors.primaryColor)),
                            const SizedBox(height: 5),

                            // Delivery Info
                            const DeliveryInfo(),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      //Quantity Button
                      SizedBox(
                          width: 60,
                          height: 40,
                          child: QuantityButton(product: cartProducts[index])),
                      const Spacer(),

                      // Favorite Button
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: FavoriteButton(product: cartProducts[index])),
                      const SizedBox(width: 10),
                      IconButton.filled(
                        onPressed: () {
                          // Remove from cart
                          context
                              .read<CartCubit>()
                              .removeFromCart(cartProducts[index]);
                        },
                        style: TextButton.styleFrom(
                            minimumSize: const Size(30, 30),
                            backgroundColor: AppColors.errorColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            )),
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
