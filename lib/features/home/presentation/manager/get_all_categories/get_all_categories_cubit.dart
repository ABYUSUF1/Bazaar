import 'package:bazaar/features/home/domain/entities/home_categories_entity.dart';
import 'package:bazaar/features/home/domain/home_repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_all_categories_state.dart';

class GetAllCategoriesCubit extends Cubit<GetAllCategoriesState> {
  GetAllCategoriesCubit(this._homeRepo) : super(GetAllCategoriesInitial());

  final HomeRepo _homeRepo;

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final result = await _homeRepo.getAllCategories();
    result.fold(
      (failure) =>
          emit(GetAllCategoriesFailure(errMessage: failure.errMessage)),
      (categories) => emit(GetAllCategoriesSuccess(categoriesList: categories)),
    );
  }
}
