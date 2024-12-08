import 'package:bazaar/core/widget/delivery_info.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_additional_info.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_price_and_discount.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_title.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/entities/products_details_entity.dart';
import '../../../../../../core/utils/models/products_details_model/product.dart';
import '../product_payment_methods_note.dart';
import '../overview/product_rating_and_review.dart';
import 'product_images_mobile.dart';

class ProductViewBodyMobile extends StatelessWidget {
  final ProductsDetailsEntity productsDetailsEntity;
  const ProductViewBodyMobile({super.key, required this.productsDetailsEntity});

  @override
  Widget build(BuildContext context) {
    final Product product = productsDetailsEntity.products![0];
    return Column(
      children: [
        ProductTitle(product: product),
        const SizedBox(height: 30),
        ProductImagesMobile(images: product.images!),
        const SizedBox(height: 20),
        ProductPriceAndDiscount(product: product),
        const SizedBox(height: 5),
        const DeliveryInfo(),
        const SizedBox(height: 20),
        const ProductPaymentMethodsNote(),
        const SizedBox(height: 20),
        ProductAdditionalInfo(product: product),
        const SizedBox(height: 20),
        ProductRatingAndReview(productDetails: productsDetailsEntity),
      ],
    );
  }
}
