import 'package:bazaar/core/widget/products_collection_items_grid.dart';
import 'package:bazaar/core/widget/title_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class FavoriteProductsList extends StatelessWidget {
  final List<Product> favoriteProducts;
  const FavoriteProductsList({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: "Favorites"),
        Text.rich(
          TextSpan(
            text: "You have ",
            style: AppTextStyles.style14Normal,
            children: <TextSpan>[
              TextSpan(
                  text: favoriteProducts.length.toString(),
                  style: AppTextStyles.style14W600
                      .copyWith(color: AppColors.primaryColor)),
              TextSpan(
                  text: " in your favorites",
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
