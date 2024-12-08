import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:bazaar/core/widget/delivery_info.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_payment_methods_note.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'product_price_and_discount.dart';

class ProductDetailsInfo extends StatelessWidget {
  final ProductsDetailsEntity productDetails;
  const ProductDetailsInfo({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    final product = productDetails.products![0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductTitle(product: product),

          const Divider(),
          const SizedBox(height: 20),

          //* Description
          _productDescription(product),
          const SizedBox(height: 20),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ///* Price and discount details
            ProductPriceAndDiscount(product: product),
            const SizedBox(height: 20),

            ///* Delivery
            const DeliveryInfo(showFullDetails: true),
            const SizedBox(height: 20),

            const ProductPaymentMethodsNote(),
            // AboutThisProduct(product: product)
          ]),
        ],
      ),
    );
  }

  Text _productDescription(Product product) {
    return Text(
      product.description!,
      style: AppTextStyles.style12BoldLightGrey,
    );
  }
}
