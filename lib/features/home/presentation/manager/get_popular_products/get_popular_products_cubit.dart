import 'package:bazaar/features/home/domain/home_repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/entities/products_details_entity.dart';
import '../../../../../core/utils/errors/failure.dart';

part 'get_popular_products_state.dart';

class GetPopularProductsCubit extends Cubit<GetPopularProductsState> {
  GetPopularProductsCubit(this._homeRepo) : super(GetPopularProductsInitial());

  final HomeRepo _homeRepo;

  Future<void> getPopularProducts() async {
    emit(GetPopularProductsLoading());
    final Either<Failure, List<ProductsDetailsEntity>> result =
        await _homeRepo.getPopularProducts();
    result.fold(
      (failure) =>
          emit(GetPopularProductsFailure(errMessage: failure.errMessage)),
      (popularProductsList) => emit(
          GetPopularProductsSuccess(popularProductsList: popularProductsList)),
    );
  }
}
