import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/utils/entities/products_details_entity.dart';
import '../../../../../../core/widget/custom_modal_bottom_sheet.dart';
import '../../../manager/get_all_category_products/get_all_category_products_cubit.dart';
import 'filter_panel/category_products_filter_panel.dart';

class CategoryHeader extends StatelessWidget {
  final int numberOfProducts;
  final String categoryName;
  final ValueChanged<String> onSortSelected;
  final ValueChanged<int> onProductLengthSelected;
  final String currentSortCriteria;
  final int currentProductDisplayLimit;
  final List<ProductsDetailsEntity> categoryProductsList;

  const CategoryHeader({
    super.key,
    required this.numberOfProducts,
    required this.categoryName,
    required this.onSortSelected,
    required this.onProductLengthSelected,
    required this.currentSortCriteria,
    required this.currentProductDisplayLimit,
    required this.categoryProductsList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProductResult(),
          // _buildDropdowns(),
          ResponsiveLayout.isMobile(context)
              ? CategoryHeaderMobile(categoryProductsList: categoryProductsList)
              : _CategoryHeaderDesktop(
                  currentProductDisplayLimit: currentProductDisplayLimit,
                  currentSortCriteria: currentSortCriteria,
                  onProductLengthSelected: onProductLengthSelected,
                  onSortSelected: onSortSelected,
                  categoryProductsList: categoryProductsList,
                )
        ],
      ),
    );
  }

  RichText _buildProductResult() {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.style14Normal,
        children: [
          TextSpan(
            text: '$numberOfProducts ',
            style: AppTextStyles.style14W600
                .copyWith(color: AppColors.primaryColor),
          ),
          const TextSpan(text: "For Results "),
          TextSpan(text: '"$categoryName"', style: AppTextStyles.style14W600),
        ],
      ),
    );
  }
}

class CategoryHeaderMobile extends StatelessWidget {
  final List<ProductsDetailsEntity> categoryProductsList;
  const CategoryHeaderMobile({super.key, required this.categoryProductsList});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          customModalBottomSheet(
              context: context,
              child: BlocProvider.value(
                  value: BlocProvider.of<GetAllCategoryProductsCubit>(context),
                  child: CategoryProductsFilterPanel(
                      categoryProductsList: categoryProductsList)));
        },
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          minimumSize: const Size(90, 40),
        ),
        label: Text(
          "Filter",
          style: AppTextStyles.style12BoldLightGrey
              .copyWith(color: AppColors.whiteColor),
        ),
        icon: const Icon(
          Icons.filter_alt,
          color: AppColors.whiteColor,
          size: 16,
        ));
  }
}

class _CategoryHeaderDesktop extends StatelessWidget {
  final String currentSortCriteria;
  final int currentProductDisplayLimit;
  final ValueChanged<String> onSortSelected;
  final ValueChanged<int> onProductLengthSelected;
  final List<ProductsDetailsEntity> categoryProductsList;
  const _CategoryHeaderDesktop(
      {required this.currentSortCriteria,
      required this.currentProductDisplayLimit,
      required this.onSortSelected,
      required this.onProductLengthSelected,
      required this.categoryProductsList});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        !ResponsiveLayout.isDesktop(context)
            ? IconButton(
                onPressed: () {
                  customModalBottomSheet(
                      context: context,
                      child: BlocProvider.value(
                          value: BlocProvider.of<GetAllCategoryProductsCubit>(
                              context),
                          child: CategoryProductsFilterPanel(
                              categoryProductsList: categoryProductsList)));
                },
                icon: const Icon(Icons.filter_alt_outlined,
                    color: AppColors.whiteColor, size: 20),
                style: IconButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(45, 45),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(width: 12),
        _buildDropdown<String>(
          value: currentSortCriteria,
          items: const {
            "Recommended": "Sort by: Recommended",
            "PriceHighToLow": "Price: High to Low",
            "PriceLowToHigh": "Price: Low to High",
            "Rating": "Rating: High to Low",
            "RatingLowToHigh": "Rating: Low to High",
          },
          onChanged: onSortSelected,
        ),
        const SizedBox(width: 12),
        _buildDropdown<int>(
          value: currentProductDisplayLimit,
          items: const {
            50: "50 products",
            100: "100 products",
            150: "150 products",
          },
          onChanged: onProductLengthSelected,
        ),
      ],
    );
  }

  Container _buildDropdown<T>({
    required T value,
    required Map<T, String> items,
    required ValueChanged<T> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColor, width: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<T>(
        value: value,
        focusColor: Colors.transparent,
        onChanged: (T? newValue) =>
            newValue != null ? onChanged(newValue) : null,
        underline: const SizedBox.shrink(),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        items: items.entries.map((entry) {
          return DropdownMenuItem(
            value: entry.key,
            child: Text(entry.value, style: AppTextStyles.style14Normal),
          );
        }).toList(),
      ),
    );
  }
}
