import 'package:bazaar/core/utils/app_router.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/widget/delivery_info.dart';
import 'package:bazaar/core/widget/favorite_button.dart';
import 'package:bazaar/core/widget/quantity_button.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_price_and_discount.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';
import '../../manager/cart/cart_cubit.dart';

class CartProductsListBody extends StatelessWidget {
  final List<Product> cartProducts;
  const CartProductsListBody({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cartProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
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
                    width: 200,
                    height: 200,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartProducts[index].title!,
                            style: AppTextStyles.style20Bold,
                          ),
                          Text(
                              cartProducts[index].brand ??
                                  cartProducts[index].category!,
                              style: AppTextStyles.style16Bold
                                  .copyWith(color: AppColors.greyColor)),
                          const SizedBox(height: 15),

                          // Delivery Info
                          const DeliveryInfo(),
                          const Spacer(),

                          // Price
                          ProductPriceAndDiscount(product: cartProducts[index]),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Remove button
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
                          Row(
                            children: [
                              //Quantity Button
                              QuantityButton(product: cartProducts[index]),
                              const SizedBox(width: 10),

                              // Favorite Button
                              FavoriteButton(product: cartProducts[index])
                            ],
                          )
                          // Quantity
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Row _deliveryInfo() {
    DateTime standardDeliveryDate = DateTime.now().add(const Duration(days: 1));
    String standardDeliveryFormatted =
        DateFormat('dd MMM').format(standardDeliveryDate);
    return Row(
      children: <Text>[
        Text("Get it by ", style: AppTextStyles.style12Normal),
        Text(
          standardDeliveryFormatted,
          style: AppTextStyles.style12BoldLightGrey
              .copyWith(color: AppColors.foregroundColor),
        ),
      ],
    );
  }
}
