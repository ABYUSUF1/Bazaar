import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import '../../../domain/favorite_repo/wishlist_repo.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepo _wishlistRepo;
  List<Product> wishlistProducts = []; // In-memory list of wishlist products

  WishlistCubit(this._wishlistRepo) : super(WishlistInitial()) {
    loadWishlist();
  }

  // Load wishlist products from the repository
  Future<void> loadWishlist() async {
    emit(WishlistLoading());
    final result = await _wishlistRepo.fetchWishlist();
    result.fold(
      (failure) => emit(WishlistFailure(failure.errMessage)),
      (wishlist) {
        wishlistProducts = wishlist.toList();
        emit(WishlistSuccess(
            wishlistProducts)); // Emit the list of wishlist products
      },
    );
  }

  // Toggle wishlist status for a product
  Future<void> toggleWishlistButton(Product product) async {
    final productId = product.id.toString();
    final isWishlist =
        wishlistProducts.any((p) => p.id.toString() == productId);

    // Optimistic update
    if (isWishlist) {
      wishlistProducts.removeWhere((p) => p.id.toString() == productId);
    } else {
      wishlistProducts.add(product);
    }
    emit(WishlistSuccess(wishlistProducts));

    try {
      if (isWishlist) {
        await _wishlistRepo.removeFromWishlist(productId);
      } else {
        await _wishlistRepo.addToWishlist(product);
      }
    } catch (e) {
      // Revert on failure
      if (isWishlist) {
        wishlistProducts.add(product);
      } else {
        wishlistProducts.removeWhere((p) => p.id.toString() == productId);
      }
      emit(WishlistFailure('Error toggling wishlist: $e'));
      emit(WishlistSuccess(wishlistProducts)); // Re-emit the reverted state
    }
  }

  // Check if a product is in wishlist
  bool isWishlist(String productId) {
    return wishlistProducts.any((p) => p.id.toString() == productId);
  }
}
