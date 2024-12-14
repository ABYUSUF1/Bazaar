part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

// Add the new property to the state
class SearchSuccess extends SearchState {
  final List<ProductsDetailsEntity> products;
  final List<String> recentSearches;

  SearchSuccess({
    required this.products,
    required this.recentSearches,
  });
}

class SearchFailure extends SearchState {
  final String errorMessage;

  SearchFailure({required this.errorMessage});
}
