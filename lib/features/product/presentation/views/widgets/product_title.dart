import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class ProductTitle extends StatelessWidget {
  final Product product;
  const ProductTitle({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // * Title
        _productTitle(product, width),
        const SizedBox(height: 4),

        ///* Rating with no. of reviews and stock availability
        Column(
          children: [
            Row(
              children: [
                _productRating(product),
                const SizedBox(width: 20),
                _productCustomerReview(product),
                const SizedBox(width: 20),
                width > 385 ? _productStock(product) : const SizedBox.shrink(),
              ],
            ),
            width > 385 ? const SizedBox.shrink() : const SizedBox(height: 5),
            width > 385 ? const SizedBox.shrink() : _productStock(product),
          ],
        ),
      ],
    );
  }

  Text _productTitle(Product product, double width) {
    return Text(product.title!,
        style: width > 420
            ? AppTextStyles.style36Bold
                .copyWith(color: AppColors.foregroundColor)
            : AppTextStyles.style26Bold);
  }

  Text _productCustomerReview(Product product) {
    return Text(
      '${product.reviews!.length.toString()} ( Customer Review )',
      style: AppTextStyles.style12BoldLightGrey,
    );
  }

  Row _productRating(Product product) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: AppColors.primaryColor,
        ),
        Text(' ${product.rating!.toString()}'),
      ],
    );
  }

  Row _productStock(Product product) {
    return Row(
      children: [
        product.stock! <= 10
            ? const Icon(
                Icons.error,
                color: AppColors.errorColor,
                size: 16,
              )
            : const Icon(
                Icons.check_circle,
                color: AppColors.checkColor,
                size: 16,
              ),
        const SizedBox(width: 10),
        product.stock! <= 10
            ? Text(
                'Only ${product.stock!} in Stock',
                style: AppTextStyles.style12BoldLightGrey.copyWith(),
              )
            : Text(
                'Remain in Stock : ${product.stock!}',
                style: AppTextStyles.style12BoldLightGrey.copyWith(),
              ),
      ],
    );
  }
}
