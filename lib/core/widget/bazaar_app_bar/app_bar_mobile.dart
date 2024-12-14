import 'package:bazaar/core/functions/is_arabic.dart';
import 'package:bazaar/core/widget/bazaar_app_bar/icon_badge.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import '../../../features/search/presentation/views/search_view.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_router.dart';

class AppBarMobile extends StatelessWidget {
  const AppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: SvgPicture.asset(
              AppAssets.imagesIconsMenu,
              width: 16,
              height: 16,
              semanticsLabel: "Menu",
            ),
            tooltip: "Open menu",
          ),
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              (context).goNamed(AppRouter.home);
            },
            child: SizedBox(
              width: 90,
              height: 20,
              child: SvgPicture.asset(
                isArabic(context)
                    ? AppAssets.imagesLogosBazaarFullLogoArabic
                    : AppAssets.imagesLogosBazaarFullLogo,
                fit: BoxFit.fill,
                semanticsLabel: "App Logo",
              ),
            ),
          ),
          actions: [
            // Wishlist Button
            CustomIconBadge(
              svgIcon: AppAssets.imagesIconsWishlist,
              onPressed: () => context.goNamed(AppRouter.wishlist),
              badgeCount:
                  context.watch<WishlistCubit>().wishlistProducts.length,
            ),

            CustomIconBadge(
              svgIcon: AppAssets.imagesIconsCart,
              onPressed: () => context.goNamed(AppRouter.cart),
              badgeCount: context.watch<CartCubit>().cartList.length,
            ),
          ],
        ),
        const SearchView(),
        const SizedBox(height: 20),
      ],
    );
  }
}
