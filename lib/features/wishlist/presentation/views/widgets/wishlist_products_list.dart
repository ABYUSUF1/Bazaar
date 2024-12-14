import 'package:bazaar/core/widget/products_collection_items_grid.dart';
import 'package:bazaar/core/widget/title_widget.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class WishlistProductsList extends StatelessWidget {
  final List<Product> favoriteProducts;
  const WishlistProductsList({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: LocaleKeys.home_wishlist.tr()),
        Text.rich(
          TextSpan(
            text: "${LocaleKeys.common_you_have.tr()} ",
            style: AppTextStyles.style14Normal,
            children: <TextSpan>[
              TextSpan(
                  text: favoriteProducts.length.toString(),
                  style: AppTextStyles.style14W600
                      .copyWith(color: AppColors.primaryColor)),
              TextSpan(
                  text: " ${LocaleKeys.common_in_your_wishlist.tr()} ",
                  style: AppTextStyles.style14Normal),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ProductsCollectionItemsGrid(
          itemCount: favoriteProducts.length,
          products: favoriteProducts,
        )
      ],
    );
  }
}
