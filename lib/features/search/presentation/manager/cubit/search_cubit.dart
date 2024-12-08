import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/features/search/domain/search_repo/search_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepo) : super(SearchInitial());

  final SearchRepo _searchRepo;

  Future<void> searchProducts({required String? query}) async {
    // Early exit if query is null or empty
    if (query == null || query.isEmpty) {
      emit(SearchFailure(errMessage: 'Please enter a search term.'));
      return;
    }

    emit(SearchLoading());

    final result = await _searchRepo.searchProducts(query);
    result.fold(
      (failure) => emit(SearchFailure(errMessage: failure.errMessage)),
      (products) {
        if (products.isEmpty) {
          emit(SearchFailure(errMessage: 'No products found.'));
        } else {
          emit(SearchSuccess(products: products));
        }
      },
    );
  }

  // Optionally, add a method to clear recent searches
  Future<void> clearRecentSearches() async {
    await _searchRepo.clearRecentSearches();
    emit(SearchInitial()); // Or any other state to indicate the list is cleared
  }
}
