import 'package:bazaar/features/home/presentation/manager/get_all_category_products/get_all_category_products_cubit.dart';
import 'package:bazaar/features/home/presentation/views/widgets/category_view_widgets/category_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/responsive_layout.dart';
import 'filter_panel/category_products_filter_panel.dart';
import 'category_products_grid.dart';

class CategoryViewBody extends StatelessWidget {
  final String categoryTitle;
  const CategoryViewBody({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllCategoryProductsCubit,
        GetAllCategoryProductsState>(
      builder: (context, state) {
        if (state is GetAllCategoryProductsFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        }
        if (state is GetAllCategoryProductsSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CategoryHeader(
                categoryProductsList: state.categoryProductsList,
                numberOfProducts: state.categoryProductsList.length,
                categoryName: categoryTitle,
                onSortSelected: (value) {
                  context
                      .read<GetAllCategoryProductsCubit>()
                      .setSortCriteria(value);
                },
                onProductLengthSelected: (value) {
                  context
                      .read<GetAllCategoryProductsCubit>()
                      .setProductDisplayLimit(value);
                },
                currentSortCriteria: state.sortCriteria,
                currentProductDisplayLimit: state.productDisplayLimit,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveLayout.isDesktop(context)
                      ? Expanded(
                          child: CategoryProductsFilterPanel(
                            categoryProductsList: state.categoryProductsList,
                          ),
                        )
                      : const SizedBox.shrink(),
                  ResponsiveLayout.isDesktop(context)
                      ? const SizedBox(width: 10)
                      : const SizedBox.shrink(),
                  Expanded(
                    flex: 4,
                    child: CategoryProductsGrid(
                        categoryProductsList: state.categoryProductsList),
                  ),
                ],
              ),
            ],
          );
        } else {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 1.5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
