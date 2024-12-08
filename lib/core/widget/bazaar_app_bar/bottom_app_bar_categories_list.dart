import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomAppBarCategoriesList extends StatefulWidget {
  const BottomAppBarCategoriesList({super.key});

  @override
  State<BottomAppBarCategoriesList> createState() =>
      _BottomAppBarCategoriesListState();
}

class _BottomAppBarCategoriesListState
    extends State<BottomAppBarCategoriesList> {
  final List<String> categories = <String>[
    LocaleKeys.home_home.tr(),
    LocaleKeys.home_deals.tr(),
    LocaleKeys.home_gift_cards.tr(),
    LocaleKeys.home_sell.tr(),
    LocaleKeys.home_customer_service.tr(),
    LocaleKeys.home_about_us.tr(),
  ];

  // Track the selected index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // Check if the current category is selected
          final bool isSelected = _selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index; // Update the selected index
                });
              },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Text(
                      categories[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors
                                .primaryColor // Change color when selected
                            : AppColors.darkColor, // Default color
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.darkColor)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
