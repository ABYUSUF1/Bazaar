import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widget/no_result_found.dart';
import '../../../../generated/locale_keys.g.dart';
import '../manager/cubit/search_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> suggestions = [];
  List<String> recentSearches = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) {
        // Prevent rebuilds if the state hasn't changed meaningfully
        if (current is SearchSuccess && previous is SearchSuccess) {
          return current.products != previous.products ||
              current.recentSearches != previous.recentSearches;
        }
        return previous != current;
      },
      builder: (context, state) {
        if (state is SearchSuccess) {
          suggestions = state.products
              .map((product) => product.products?.first.title ?? '')
              .toList();
          recentSearches = state.recentSearches;
        } else if (state is SearchFailure) {
          suggestions = ['No results found'];
        }

        return Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: SearchField(
            controller: _searchController,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            suggestions: suggestions.isEmpty
                ? recentSearches.map((e) => SearchFieldListItem(e)).toList()
                : suggestions.map((e) => SearchFieldListItem(e)).toList(),
            onSuggestionTap: (p0) {
              context.read<SearchCubit>().addRecentSearch(p0.searchKey);
              _searchController.clear();
              context.read<SearchCubit>().fetchRecentSearches();
            },
            onSearchTextChanged: (query) {
              context.read<SearchCubit>().searchProducts(query);
              return null;
            },
            searchInputDecoration: SearchInputDecoration(
              hintText: LocaleKeys.home_search_hint.tr(),
              hintStyle: AppTextStyles.style14Normal
                  .copyWith(color: AppColors.greyColor),
              filled: true,
              suffixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
              fillColor: AppColors.secondaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 2.0),
              ),
            ),
            suggestionsDecoration: SuggestionDecoration(
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.all(10),
            ),
            emptyWidget: const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: NoResultFound(
                    lottieImage: AppAssets.lottiesEmptySearch,
                    message: "Empty"),
              ),
            ),
          ),
        );
      },
    );
  }
}
