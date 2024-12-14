import 'package:bazaar/features/wishlist/presentation/views/widgets/wishlist_products_list.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class WishlistViewBody extends StatelessWidget {
  final List<Product> wishlistProducts;
  const WishlistViewBody({super.key, required this.wishlistProducts});

  @override
  Widget build(BuildContext context) {
    return WishlistProductsList(favoriteProducts: wishlistProducts);
  }
}
