import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_sold_by.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_trust_and_security.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_warranty_and_delivery.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/models/products_details_model/product.dart';
import '../../../../../core/widget/add_to_cart_button.dart';
import '../../../../../core/widget/favorite_button.dart';
import '../../../../../core/widget/quantity_button.dart';

class ProductAdditionalInfo extends StatelessWidget {
  final Product product;
  const ProductAdditionalInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///* Warranty && Return Policy
        ProductWarrantyAndReturnPolicy(product: product),
        const SizedBox(height: 20),

        ///* Sold By
        const ProductSoldBy(),
        const SizedBox(height: 20),

        ///* Product trust and security
        const ProductTrustAndSecurity(),
        const SizedBox(height: 40),

        ///* Add To Cart && Favorite && QTY Buttons
        ResponsiveLayout.isDesktop(context)
            ? _productFavoriteAndCartAndQtyButtons(product)
            : const SizedBox.shrink()
      ],
    );
  }

  Row _productFavoriteAndCartAndQtyButtons(Product product) {
    return Row(
      children: [
        // Favorite Button
        FavoriteButton(product: product),
        const SizedBox(width: 10),

        // Expanded Cart Button
        Expanded(child: AddToCartButton(product: product)),

        const SizedBox(width: 10),

        // Quantity Button

        QuantityButton(product: product),
      ],
    );
  }
}
