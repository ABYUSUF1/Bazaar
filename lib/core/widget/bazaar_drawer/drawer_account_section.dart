import 'package:bazaar/core/functions/is_arabic.dart';
import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import 'package:bazaar/features/wishlist/presentation/manager/wishlist/wishlist_state.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
          padding: EdgeInsets.only(
              left: isArabic(context) ? 0.0 : 16.0,
              right: isArabic(context) ? 16.0 : 0.0),
          child: Text(LocaleKeys.home_account.tr(),
              style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        Column(children: [
          CustomListTile(
              title: LocaleKeys.home_orders.tr(),
              svgIcon: AppAssets.imagesIconsOrders),
          CustomListTile(
              title: LocaleKeys.home_returns.tr(),
              svgIcon: AppAssets.imagesIconsReturns),
          const _WishList(),
          CustomListTile(
              title: LocaleKeys.home_address.tr(),
              svgIcon: AppAssets.imagesIconsLocation),
          CustomListTile(
              title: LocaleKeys.home_payment.tr(),
              svgIcon: AppAssets.imagesIconsPayment),
          CustomListTile(
              title: LocaleKeys.home_wallet.tr(),
              svgIcon: AppAssets.imagesIconsWallet),
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
        title: LocaleKeys.home_wishlist.tr(),
        svgIcon: AppAssets.imagesIconsWishlist,
        besideTitleChild: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 10,
          child: BlocBuilder<WishlistCubit, WishlistState>(
            builder: (context, state) {
              if (state is WishlistSuccess) {
                return Text(state.wishlistProducts.length.toString(),
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
