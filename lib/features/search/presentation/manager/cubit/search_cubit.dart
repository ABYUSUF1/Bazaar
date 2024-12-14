import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/entities/products_details_entity.dart';
import '../../../domain/search_repo/search_repo.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;

  SearchCubit(this._searchRepo) : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    // If the query length is less than 3, just show recent searches
    if (query.isEmpty || query.length < 3) {
      return;
    }

    // Once the query length reaches 3 or more, search for products
    emit(SearchLoading());

    final result = await _searchRepo.searchProducts(query);
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errMessage)),
      (products) async {
        emit(SearchSuccess(products: products, recentSearches: []));
      },
    );
  }

  // Fetch recent searches (when query length is < 3)
  Future<void> fetchRecentSearches() async {
    final result = await _searchRepo.getRecentSearches();
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errMessage)),
      (recentSearches) => emit(
        SearchSuccess(
          products: [],
          recentSearches: recentSearches,
        ),
      ),
    );
  }

  Future<void> addRecentSearch(String query) async {
    final result = await _searchRepo.addRecentSearch(query);
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errMessage)),
      (_) => fetchRecentSearches(),
    );
  }

  // Remove a search query from recent searches
  Future<void> removeRecentSearch(String query) async {
    final result = await _searchRepo.removeRecentSearch(query);
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errMessage)),
      (_) => fetchRecentSearches(),
    );
  }

  // Clear all recent searches
  Future<void> clearRecentSearches() async {
    final result = await _searchRepo.clearRecentSearches();
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errMessage)),
      (_) => fetchRecentSearches(),
    );
  }
}
