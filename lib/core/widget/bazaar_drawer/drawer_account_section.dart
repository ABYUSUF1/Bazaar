import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/favorite/presentation/manager/favorite/favorite_cubit.dart';
import 'package:bazaar/features/favorite/presentation/manager/favorite/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_router.dart';
import '../custom_list_tile.dart';

class DrawerAccountSection extends StatelessWidget {
  const DrawerAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Account", style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        const Column(children: [
          CustomListTile(title: "Orders", svgIcon: AppAssets.imagesIconsOrders),
          CustomListTile(
              title: "Returns", svgIcon: AppAssets.imagesIconsReturns),
          _WishList(),
          CustomListTile(
              title: "Addresses", svgIcon: AppAssets.imagesIconsLocation),
          CustomListTile(
              title: "Payment", svgIcon: AppAssets.imagesIconsPayment),
          CustomListTile(title: "Wallet", svgIcon: AppAssets.imagesIconsWallet),
        ]),
      ],
    );
  }
}

class _WishList extends StatelessWidget {
  const _WishList();

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
        onTap: () => context.goNamed(AppRouter.wishlist),
        title: "Wishlist",
        svgIcon: AppAssets.imagesIconsWishlist,
        besideTitleChild: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 10,
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteSuccess) {
                return Text(state.favoriteProducts.length.toString(),
                    style: AppTextStyles.style10NormalLightGrey
                        .copyWith(color: AppColors.whiteColor));
              } else {
                return const Text("Loading");
              }
            },
          ),
        ));
  }
}
