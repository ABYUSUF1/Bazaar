part of 'get_all_categories_cubit.dart';

@immutable
sealed class GetAllCategoriesState {}

final class GetAllCategoriesInitial extends GetAllCategoriesState {}

final class GetAllCategoriesLoading extends GetAllCategoriesState {}

final class GetAllCategoriesSuccess extends GetAllCategoriesState {
  final List<HomeCategoriesEntity> categoriesList;
  GetAllCategoriesSuccess({required this.categoriesList});
}

final class GetAllCategoriesFailure extends GetAllCategoriesState {
  final String errMessage;

  GetAllCategoriesFailure({required this.errMessage});
}
