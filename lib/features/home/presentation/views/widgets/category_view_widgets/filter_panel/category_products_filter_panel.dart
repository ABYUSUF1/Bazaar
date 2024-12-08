import 'package:bazaar/features/home/presentation/views/widgets/category_view_widgets/filter_panel/brand_filter_panel.dart';
import 'package:bazaar/features/home/presentation/views/widgets/category_view_widgets/filter_panel/rating_filter_panel.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/entities/products_details_entity.dart';
import 'price_filter_panel.dart';

class CategoryProductsFilterPanel extends StatelessWidget {
  final List<ProductsDetailsEntity> categoryProductsList;
  const CategoryProductsFilterPanel(
      {super.key, required this.categoryProductsList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PriceFilterPanel(),
        BrandFilterPanel(categoryList: categoryProductsList),
        const RatingFilterPanel(),
      ],
    );
  }
}
