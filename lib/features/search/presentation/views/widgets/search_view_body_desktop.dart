import 'package:bazaar/core/functions/is_arabic.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/home/domain/entities/home_categories_entity.dart';
import 'package:bazaar/features/home/presentation/manager/get_all_categories/get_all_categories_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_colors.dart';

class SearchViewBodyDesktop extends StatelessWidget {
  const SearchViewBodyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllCategoriesCubit, GetAllCategoriesState>(
      builder: (context, state) {
        return state is GetAllCategoriesSuccess
            ? Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 50, left: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      )),
                  child: Row(
                    children: [
                      _SearchFieldDropDownButton(
                        categoriesList: state.categoriesList,
                      ),
                      const VerticalDivider(
                        indent: 15,
                        endIndent: 15,
                        color: AppColors.foregroundColor2,
                      ),
                      const _SearchField()
                    ],
                  ),
                ),
              )
            : Skeletonizer(
                enabled: state is GetAllCategoriesLoading, child: Container());
      },
    );
  }
}

class _SearchFieldDropDownButton extends StatefulWidget {
  final List<HomeCategoriesEntity> categoriesList;

  const _SearchFieldDropDownButton({required this.categoriesList});

  @override
  _SearchFieldDropDownButtonState createState() =>
      _SearchFieldDropDownButtonState();
}

class _SearchFieldDropDownButtonState
    extends State<_SearchFieldDropDownButton> {
  // Initial Selected Value
  String? initialValue;

  // List of items in our dropdown menu
  late List<String?> items;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize the items list with "all categories"
    items = [LocaleKeys.home_all_categories.tr()];

    // Add categories from current api response
    items.addAll(widget.categoriesList.map((category) {
      return isArabic(context)
          ? category.localizedTitle!.ar
          : category.localizedTitle!.en;
    }).toList());

    // Set the initial value to the first item
    initialValue = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        // Initial Value
        value: initialValue, // Correctly bind the initial value

        // Down Arrow Icon
        icon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.keyboard_arrow_down_rounded)),
        focusColor: Colors.transparent,
        padding: const EdgeInsets.only(left: 10, right: 10),
        items: items.map((String? items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items!,
              style: AppTextStyles.style14W600,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            initialValue = newValue!;
          });
        },
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField();

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SearchField(
        suggestions: items.map((e) => SearchFieldListItem(e)).toList(),
        controller: searchController,
        focusNode: FocusNode(),
        searchInputDecoration: SearchInputDecoration(
          searchStyle: AppTextStyles.style14Normal,
          contentPadding: const EdgeInsets.only(top: 13.0),
          hintText: LocaleKeys.home_search_hint.tr(),
          hintStyle: AppTextStyles.style12BoldLightGrey,
          border: InputBorder.none,
          suffixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.foregroundColor2,
          ),
        ),
      ),
    );
  }
}
