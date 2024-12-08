import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import '../../features/favorite/presentation/manager/favorite/favorite_cubit.dart';
import '../../features/favorite/presentation/manager/favorite/favorite_state.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final Product product;

  const FavoriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isFavorite = favoriteCubit.isFavorite(product.id.toString());

        return IconButton(
          onPressed: () {
            if (state is FavoriteSuccess) {
              context.read<FavoriteCubit>().toggleFavorite(product);
            }
          },
          style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              minimumSize: const Size(50, 50),
              backgroundColor: AppColors.foregroundColor2.withOpacity(.6)),
          icon: ZoomIn(
            child: SvgPicture.asset(
              AppAssets.imagesIconsFavorite,
              color: isFavorite ? AppColors.errorColor : AppColors.greyColor,
              width: 20,
              height: 20,
            ),
          ),
          tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
        );
      },
    );
  }
}