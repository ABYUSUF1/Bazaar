import 'package:bazaar/core/functions/is_arabic.dart';
import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/utils/app_router.dart';
import 'package:bazaar/core/widget/bazaar_app_bar/bottom_app_bar_categories_list.dart';
import 'package:bazaar/core/widget/bazaar_app_bar/icon_badge.dart';
import 'package:bazaar/core/widget/bazaar_app_bar/location_button.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../features/cart/presentation/manager/cart/cart_cubit.dart';
import '../../../features/favorite/presentation/manager/favorite/favorite_cubit.dart';
import '../../../features/search/presentation/views/widgets/search_view_body_desktop.dart';
import '../../utils/app_colors.dart';

class AppBarDesktop extends StatelessWidget {
  const AppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 132,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _UpperAppBar(),
          Divider(),
          _BottomAppBar(),
          Divider(),
        ],
      ),
    );
  }
}

class _UpperAppBar extends StatelessWidget {
  const _UpperAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        InkWell(
          onTap: () {
            // GO TO HOME
            GoRouter.of(context).go(AppRouter.home);
          },
          child: SizedBox(
            width: 150,
            height: 50,
            child: SvgPicture.asset(
              isArabic(context)
                  ? AppAssets.imagesLogosBazaarFullLogoArabic
                  : AppAssets.imagesLogosBazaarFullLogo,
            ),
          ),
        ),

        // Search field
        const SearchViewBodyDesktop(),

        // Location Button
        const LocationButton(),

        // Wishlist Button
        CustomIconBadge(
          svgIcon: AppAssets.imagesIconsWishlist,
          onPressed: () => context.goNamed(AppRouter.wishlist),
          labelText: LocaleKeys.home_wishlist
              .tr(), //! change from wishlist to favorite
          badgeCount: context.watch<FavoriteCubit>().favoriteProducts.length,
        ),

        // Cart Button
        CustomIconBadge(
          svgIcon: AppAssets.imagesIconsCart,
          onPressed: () => context.pushNamed(AppRouter.cart),
          labelText: LocaleKeys.home_cart.tr(),
          badgeCount: context.watch<CartCubit>().cartList.length,
        ),

        // Account Button
        CustomIconBadge(
          svgIcon: AppAssets.imagesIconsProfile,
          onPressed: () => context.pushNamed(AppRouter.profile),
          labelText: LocaleKeys.home_account.tr(),
          badgeCount: 0,
        ),
      ],
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                // Open drawer
                Scaffold.of(context).openDrawer();
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(LocaleKeys.home_all.tr())),
          const BottomAppBarCategoriesList(),
        ],
      ),
    );
  }
}
