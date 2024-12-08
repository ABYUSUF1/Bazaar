import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widget/products_collection_items_grid.dart';
import '../../../../../../core/widget/title_widget.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../manager/get_popular_products/get_popular_products_cubit.dart';

class HomePopularProducts extends StatelessWidget {
  const HomePopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          title: LocaleKeys.home_popular_products.tr(),
          displayViewAllButton: true,
        ),
        const _PopularProductsList(),
      ],
    );
  }
}

class _PopularProductsList extends StatelessWidget {
  const _PopularProductsList();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<GetPopularProductsCubit, GetPopularProductsState>(
      builder: (context, state) {
        if (state is GetPopularProductsFailure) {
          return Text(state.errMessage);
        } else if (state is GetPopularProductsSuccess) {
          return SizedBox(
            width: double.infinity,
            child: ProductsCollectionItemsGrid(
              itemCount: _determineProductLimit(
                  width, state.popularProductsList.length, context),
              products: state.popularProductsList
                  .expand((item) => item.products!)
                  .toList(),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  int _determineProductLimit(
      double width, int totalProducts, BuildContext context) {
    if (width > 1377) {
      return totalProducts;
    } else if (width > 1160 && width <= 1377) {
      return 12;
    } else if (width > 944 && width <= 1160) {
      return 10;
    } else if (width > 664 && width <= 944) {
      return 8;
    } else if (width > 448 && width <= 664) {
      return 6;
    } else {
      return 4;
    }
  }
}
