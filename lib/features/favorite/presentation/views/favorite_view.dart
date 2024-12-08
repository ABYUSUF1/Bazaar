import 'package:bazaar/core/widget/custom_scaffold.dart';
import 'package:bazaar/features/favorite/presentation/manager/favorite/favorite_cubit.dart';
import 'package:bazaar/features/favorite/presentation/views/widgets/favorite_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/favorite/favorite_state.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body:
          BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FavoriteSuccess) {
          final favoriteProducts = state.favoriteProducts;

          if (favoriteProducts.isEmpty) {
            return const Center(child: Text("No favorites added yet."));
          } else {
            return FavoriteViewBody(favoritesProducts: favoriteProducts);
          }
        } else if (state is FavoriteFailure) {
          return Center(child: Text(state.errMessage));
        }
        return const Center(child: Text("Something went wrong"));
      }),
    );
  }
}
