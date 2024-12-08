import 'package:bazaar/core/widget/no_result_found.dart';
import 'package:bazaar/core/widget/products_collection_items_grid.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/entities/products_details_entity.dart';

class CategoryProductsGrid extends StatelessWidget {
  final List<ProductsDetailsEntity> categoryProductsList;
  const CategoryProductsGrid({super.key, required this.categoryProductsList});

  @override
  Widget build(BuildContext context) {
    // Flatten the list of products from all entities
    final allProducts =
        categoryProductsList.expand((entity) => entity.products!).toList();

    if (allProducts.isEmpty) {
      return const Expanded(
          flex: 4,
          child: NoResultFound(
            lottieImage: AppAssets.lottiesEmptySearch,
            message: "Empty category product until you make message",
          ));
    }
    return SizedBox(
      child: ProductsCollectionItemsGrid(
        products:
            categoryProductsList.expand((item) => item.products!).toList(),
        itemCount: allProducts.length,
      ),
    );
  }
}
