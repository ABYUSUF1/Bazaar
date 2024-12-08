import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import '../../../domain/favorite_repo/favorite_repo.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo _favoriteRepo;
  List<Product> favoriteProducts = []; // In-memory list of favorite products

  FavoriteCubit(this._favoriteRepo) : super(FavoriteInitial()) {
    loadFavorites();
  }

  // Load favorite products from the repository
  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    final result = await _favoriteRepo.fetchFavorites();
    result.fold(
      (failure) => emit(FavoriteFailure(failure.errMessage)),
      (productList) {
        favoriteProducts = productList.toList();
        emit(FavoriteSuccess(
            favoriteProducts)); // Emit the list of favorite products
      },
    );
  }

  // Toggle favorite status for a product
  Future<void> toggleFavorite(Product product) async {
    final productId = product.id.toString();
    final isFavorite =
        favoriteProducts.any((p) => p.id.toString() == productId);

    // Optimistic update
    if (isFavorite) {
      favoriteProducts.removeWhere((p) => p.id.toString() == productId);
    } else {
      favoriteProducts.add(product);
    }
    emit(FavoriteSuccess(favoriteProducts));

    try {
      if (isFavorite) {
        await _favoriteRepo.removeFavorite(productId);
      } else {
        await _favoriteRepo.addFavorite(product);
      }
    } catch (e) {
      // Revert on failure
      if (isFavorite) {
        favoriteProducts.add(product);
      } else {
        favoriteProducts.removeWhere((p) => p.id.toString() == productId);
      }
      emit(FavoriteFailure('Error toggling favorite: $e'));
      emit(FavoriteSuccess(favoriteProducts)); // Re-emit the reverted state
    }
  }

  // Check if a product is in favorites
  bool isFavorite(String productId) {
    return favoriteProducts.any((p) => p.id.toString() == productId);
  }
}
