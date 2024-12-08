import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/features/home/presentation/views/widgets/category_view_widgets/filter_panel/filter_box.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/entities/products_details_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bazaar/features/home/presentation/manager/get_all_category_products/get_all_category_products_cubit.dart';

class BrandFilterPanel extends StatefulWidget {
  final List<ProductsDetailsEntity> categoryList;

  const BrandFilterPanel({super.key, required this.categoryList});

  @override
  State<BrandFilterPanel> createState() => _BrandFilterPanelState();
}

class _BrandFilterPanelState extends State<BrandFilterPanel> {
  final Set<String> _selectedBrands = {}; // Tracks selected brands
  late final List<String> _allBrands; // Stores unique brands from products

  @override
  void initState() {
    super.initState();
    _allBrands = _extractAllBrands(); // Initialize the list of all brands
  }

  // Extract unique brands from product list
  List<String> _extractAllBrands() {
    final Set<String> brandsSet = {};
    for (final productEntity in widget.categoryList) {
      final products = productEntity.products;
      if (products != null) {
        for (final product in products) {
          final brand = product.brand;
          if (brand != null) {
            brandsSet.add(brand); // Add brand to the set
          }
        }
      }
    }
    return brandsSet.toList(); // Convert set to list
  }

  void _updateSelectedBrands(String brand, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedBrands.add(brand); // Add brand to selected set
      } else {
        _selectedBrands.remove(brand); // Remove brand from selected set
      }
    });

    // Notify the Cubit to filter products by the selected brands
    context
        .read<GetAllCategoryProductsCubit>()
        .setSelectedBrands(_selectedBrands);
  }

  void _clearSelectedBrands() {
    setState(() {
      _selectedBrands.clear(); // Clear all selected brands
    });
    context.read<GetAllCategoryProductsCubit>().clearBrandFilter();
  }

  @override
  Widget build(BuildContext context) {
    final isFilterApplied =
        _selectedBrands.isNotEmpty; // Check if any brand is selected

    return FilterBox(
      title: 'Brands',
      isFilterApplied: isFilterApplied,
      onClear:
          _clearSelectedBrands, // Clear filter when "Clear" button is clicked
      child: ListView.builder(
        itemCount: _allBrands.length, // Display all brands
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final brand = _allBrands[index];
          return CheckboxListTile(
            activeColor: AppColors.primaryColor,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.only(left: 0, right: 0),
            title: Text(brand), // Display brand name
            value:
                _selectedBrands.contains(brand), // Check if brand is selected
            onChanged: (bool? newValue) {
              _updateSelectedBrands(
                  brand, newValue ?? false); // Update selection and filter
            },
          );
        },
      ),
    );
  }
}
