import 'package:bazaar/core/functions/get_color_for_rating.dart';
import 'package:bazaar/core/utils/app_router.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/widget/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_colors.dart';
import '../utils/models/products_details_model/product.dart';
import 'delivery_info.dart';

class ProductsCollectionItemsGrid extends StatelessWidget {
  final int itemCount;
  final List<Product> products;

  const ProductsCollectionItemsGrid({
    super.key,
    required this.itemCount,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 9 / 18, // Dynamically calculated
        ),
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return _ProductsCollectionItems(
            products: products[index],
          );
        },
      ),
    );
  }
}

class _ProductsCollectionItems extends StatelessWidget {
  const _ProductsCollectionItems({required this.products});

  final Product products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(AppRouter.product, pathParameters: {
          'productTitle': products.title!,
          'productId': products.id!.toString()
        });
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.foregroundColor2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Ensures the column wraps content
          children: [
            //* Image Part
            Flexible(
              child: Stack(
                alignment: Alignment.topRight,
                clipBehavior: Clip.antiAlias,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.3),
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: AppColors.secondaryColor,
                    child: CachedNetworkImage(
                      imageUrl: products.images![0]!,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: AppColors.errorColor,
                      ),
                    ),
                  ),
                  FavoriteButton(product: products),
                ],
              ),
            ),
            const SizedBox(height: 5),

            //* Details Part
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Ensures column wraps content
                children: [
                  /// Title
                  Text(
                    products.title!,
                    style: AppTextStyles.style14W600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),

                  /// Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: getColorForRating(products.rating!),
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${products.rating!})',
                        style: AppTextStyles.style10NormalLightGrey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Price and Discount
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '\$ ',
                        style: AppTextStyles.style10NormalLightGrey
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        '${products.price!}',
                        style: AppTextStyles.style14W600
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${(products.price! / (1 - (products.discountPercentage! / 100))).floor()}',
                        style: AppTextStyles.style12Normal.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (products.discountPercentage! > 0)
                        Text(
                          '- (${products.discountPercentage!}%)',
                          style: AppTextStyles.style10NormalLightGrey,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  /// Delivery Info
                  const DeliveryInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
