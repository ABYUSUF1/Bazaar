import 'package:bazaar/features/favorite/presentation/views/widgets/favorite_products_list.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class FavoriteViewBody extends StatelessWidget {
  final List<Product> favoritesProducts;
  const FavoriteViewBody({super.key, required this.favoritesProducts});

  @override
  Widget build(BuildContext context) {
    return FavoriteProductsList(favoriteProducts: favoritesProducts);
  }
}
