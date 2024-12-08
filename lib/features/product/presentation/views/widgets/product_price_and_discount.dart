import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class ProductPriceAndDiscount extends StatelessWidget {
  final Product product;
  final TextStyle? priceStyle;
  final bool showDiscountPercentage;
  const ProductPriceAndDiscount(
      {super.key,
      required this.product,
      this.priceStyle,
      this.showDiscountPercentage = true});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  Currency
        _currency(),

        // Price
        _price(width),
        const SizedBox(width: 10),

        // Price before discount
        _priceBeforeDiscount(product),

        // discount percentage
        if (product.discountPercentage! > 0 && showDiscountPercentage)
          _discountPercentage(product),
      ],
    );
  }

  Text _currency() {
    return Text('\$ ',
        style: AppTextStyles.style14Normal
            .copyWith(color: AppColors.primaryColor));
  }

  Text _price(double width) {
    return Text('${product.price!}'.toString(),
        style: priceStyle ??
            (width > 420
                    ? AppTextStyles.style36Bold
                    : AppTextStyles.style26Bold)
                .copyWith(color: AppColors.primaryColor));
  }

  Text _priceBeforeDiscount(Product product) {
    return Text(
      '\$${(product.price! / (1 - (product.discountPercentage! / 100))).floor()}',
      style: AppTextStyles.style14Normal
          .copyWith(decoration: TextDecoration.lineThrough),
    );
  }

  Row _discountPercentage(Product product) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text('- (${product.discountPercentage!}%)',
            style:
                AppTextStyles.style14W600.copyWith(color: AppColors.checkColor))
      ],
    );
  }
}
