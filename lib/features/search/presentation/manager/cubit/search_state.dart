part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductsDetailsEntity> products;

  SearchSuccess({required this.products});
}

class SearchFailure extends SearchState {
  final String errMessage;

  SearchFailure({required this.errMessage});
}
