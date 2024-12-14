import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/features/home/presentation/views/widgets/category_view_widgets/filter_panel/filter_box.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../manager/get_all_category_products/get_all_category_products_cubit.dart';

class PriceFilterPanel extends StatefulWidget {
  const PriceFilterPanel({super.key});

  @override
  State<PriceFilterPanel> createState() => _PriceFilterPanelState();
}

class _PriceFilterPanelState extends State<PriceFilterPanel> {
  double _minPrice = 0;
  double _maxPrice = 2000; // Default price range

  @override
  Widget build(BuildContext context) {
    final isFilterApplied = _minPrice != 0 || _maxPrice != 2000;

    return FilterBox(
      title: LocaleKeys.category_filters_price_range.tr(),
      isFilterApplied: isFilterApplied,
      onClear: () {
        setState(() {
          _minPrice = 0;
          _maxPrice = 2000; // Reset to default values
        });
        context.read<GetAllCategoryProductsCubit>().clearPriceFilter();
      },
      child: Column(
        children: [
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 2000,
            divisions: 20,
            activeColor: AppColors.primaryColor,
            labels:
                RangeLabels('\$${_minPrice.round()}', '\$${_maxPrice.round()}'),
            onChanged: (newRange) {
              setState(() {
                _minPrice = newRange.start;
                _maxPrice = newRange.end;
              });
              context
                  .read<GetAllCategoryProductsCubit>()
                  .setPriceRange(_minPrice, _maxPrice);
            },
          ),
          Text(
            '\$$_minPrice   -   \$$_maxPrice',
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
