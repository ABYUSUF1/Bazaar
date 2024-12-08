import 'package:bazaar/features/product/presentation/views/widgets/product_details.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/entities/products_details_entity.dart';
import '../overview/product_rating_and_review.dart';

class ProductViewBodyDesktop extends StatelessWidget {
  final ProductsDetailsEntity productsDetailsEntity;
  const ProductViewBodyDesktop(
      {super.key, required this.productsDetailsEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///* display Image - title - price, .......
        ProductDetails(productDetails: productsDetailsEntity),

        const SizedBox(height: 30),

        ///* Product Ratings And Reviews
        ProductRatingAndReview(productDetails: productsDetailsEntity),
      ],
    );
  }
}
