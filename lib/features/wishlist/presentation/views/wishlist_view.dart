import 'package:bazaar/core/widget/custom_scaffold.dart';
import 'package:bazaar/features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import 'package:bazaar/features/wishlist/presentation/views/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/wishlist/wishlist_state.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body:
          BlocBuilder<WishlistCubit, WishlistState>(builder: (context, state) {
        if (state is WishlistLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is WishlistSuccess) {
          final wishlistProducts = state.wishlistProducts;

          if (wishlistProducts.isEmpty) {
            return const Center(child: Text("No Wishlists added yet."));
          } else {
            return WishlistViewBody(wishlistProducts: wishlistProducts);
          }
        } else if (state is WishlistFailure) {
          return Center(child: Text(state.errMessage));
        }
        return const Center(child: Text("Something went wrong"));
      }),
    );
  }
}
