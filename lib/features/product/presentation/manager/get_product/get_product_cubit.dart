import 'package:bazaar/features/product/domain/repo/product_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/entities/products_details_entity.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit(this._productRepo) : super(GetProductInitial());

  final ProductRepo _productRepo;

  Future<void> getProduct({required String productId}) async {
    emit(GetProductLoading());
    final result = await _productRepo.getProduct(productId: productId);
    result.fold(
      (failure) => emit(GetProductFailure(errMessage: failure.errMessage)),
      (product) => emit(GetProductSuccess(productsDetailsEntity: product)),
    );
  }
}
