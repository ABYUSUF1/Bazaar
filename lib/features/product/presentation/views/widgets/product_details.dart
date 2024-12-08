import 'package:bazaar/features/product/presentation/views/widgets/product_details_info.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_additional_info.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/entities/products_details_entity.dart';
import 'product_view_desktop/product_images_desktop.dart';

class ProductDetails extends StatelessWidget {
  final ProductsDetailsEntity productDetails;
  const ProductDetails({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child:
              ProductImagesDesktop(images: productDetails.products![0].images!),
        ),
        Expanded(
          flex: 3,
          child: ProductDetailsInfo(productDetails: productDetails),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 2,
          child: ProductAdditionalInfo(product: productDetails.products![0]),
        ),
      ],
    );
  }
}
