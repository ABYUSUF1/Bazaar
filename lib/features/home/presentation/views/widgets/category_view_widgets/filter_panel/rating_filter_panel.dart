import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/features/home/presentation/views/widgets/category_view_widgets/filter_panel/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../manager/get_all_category_products/get_all_category_products_cubit.dart';

class RatingFilterPanel extends StatefulWidget {
  const RatingFilterPanel({super.key});

  @override
  State<RatingFilterPanel> createState() => _RatingFilterPanelState();
}

class _RatingFilterPanelState extends State<RatingFilterPanel> {
  double _currentRating = 1.0; // Default rating

  @override
  Widget build(BuildContext context) {
    final isFilterApplied =
        _currentRating > 1.0; // Check if rating filter is active

    return FilterBox(
      title: 'Rating',
      isFilterApplied: isFilterApplied,
      onClear: () {
        setState(() {
          _currentRating = 1.0; // Reset rating to default
        });
        context.read<GetAllCategoryProductsCubit>().clearRatingFilter();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: _currentRating,
            min: 1.0,
            max: 5.0,
            divisions: 4, // Creates 4 divisions (1, 2, 3, 4, 5)
            activeColor: AppColors.primaryColor,
            label: _currentRating.round().toString(),
            onChanged: (double newValue) {
              setState(() {
                _currentRating = newValue;
              });
              // Call the filter method in the Cubit
              BlocProvider.of<GetAllCategoryProductsCubit>(context)
                  .setRating(_currentRating);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < _currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              );
            }),
          ),
        ],
      ),
    );
  }
}
