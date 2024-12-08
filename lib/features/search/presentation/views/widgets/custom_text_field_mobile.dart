import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../manager/cubit/search_cubit.dart';

class CustomSearchFieldMobile extends StatefulWidget {
  const CustomSearchFieldMobile({super.key});

  @override
  State<CustomSearchFieldMobile> createState() =>
      _CustomSearchFieldMobileState();
}

class _CustomSearchFieldMobileState extends State<CustomSearchFieldMobile> {
  // Create a TextEditingController to capture input text
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        List<String> suggestions = [];

        // Update suggestions based on the state
        if (state is SearchSuccess) {
          suggestions = state.products
              .map((product) => product.products?.first.title ?? '')
              .toList();
        } else if (state is SearchFailure) {
          suggestions = ['No results found'];
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SearchField(
                controller: _searchController, // Attach the controller
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                suggestions:
                    suggestions.map((e) => SearchFieldListItem(e)).toList(),
                searchInputDecoration: SearchInputDecoration(
                  hintText: 'Search for products...',
                  hintStyle: AppTextStyles.style14Normal
                      .copyWith(color: AppColors.greyColor),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded, color: Colors.grey),
                    onPressed: () {
                      // Trigger search when user presses the search button
                      String query = _searchController.text.trim();
                      if (query.isNotEmpty) {
                        context
                            .read<SearchCubit>()
                            .searchProducts(query: query);
                      }
                    },
                  ),
                  fillColor: AppColors.secondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 2.0),
                  ),
                ),

                emptyWidget: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 5), // Adjust the offset
                        )
                      ]),
                  child: Text(
                    'No results found',
                    style: AppTextStyles.style14Normal
                        .copyWith(color: AppColors.greyColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
