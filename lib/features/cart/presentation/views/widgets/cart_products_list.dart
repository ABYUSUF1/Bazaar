import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/cart_products_list_body.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/cart_products_list_body_mobile.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';
import '../../../../../core/widget/title_widget.dart';

class CartProductsList extends StatelessWidget {
  final List<Product> cartProducts;
  const CartProductsList({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: "Cart"),
        Text.rich(
          TextSpan(
            text: "You have ",
            style: AppTextStyles.style14Normal,
            children: <TextSpan>[
              TextSpan(
                  text: cartProducts.length.toString(),
                  style: AppTextStyles.style14W600
                      .copyWith(color: AppColors.primaryColor)),
              TextSpan(
                  text: " in your cart", style: AppTextStyles.style14Normal),
            ],
          ),
        ),
        // const SizedBox(height: 20),
        ResponsiveLayout.isDesktop(context)
            ? CartProductsListBody(cartProducts: cartProducts)
            : CartProductsListBodyMobile(cartProducts: cartProducts)
      ],
    );
  }
}
