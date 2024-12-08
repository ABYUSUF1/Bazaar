import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/core/utils/models/products_details_model/product.dart';
import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../core/functions/get_color_for_rating.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import 'rating_breakdown.dart';

class RatingOverview extends StatelessWidget {
  final ProductsDetailsEntity productsDetails;

  const RatingOverview({super.key, required this.productsDetails});

  @override
  Widget build(BuildContext context) {
    final product = productsDetails.products!.first;
    final starColor = getColorForRating(product.rating);

    return ResponsiveLayout.isMobile(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _overallRating(context, product, starColor)),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: RatingBreakdown(
                    reviews: product.reviews!,
                    getColorForRating: getColorForRating),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _overallRating(context, product, starColor),
              const SizedBox(height: 20),
              RatingBreakdown(
                  reviews: product.reviews!,
                  getColorForRating: getColorForRating),
            ],
          );
  }

  Column _overallRating(
      BuildContext context, Product product, Color starColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context),
        SizedBox(height: ResponsiveLayout.isMobile(context) ? 5 : 20),
        _ratingNumber(product),
        _ratingStars(product, starColor, context),
        _numberOfReviews(product, context),
      ],
    );
  }

  Text _numberOfReviews(Product product, BuildContext context) {
    return Text(
      'Based on ${product.reviews!.length} ratings',
      style: ResponsiveLayout.isMobile(context)
          ? AppTextStyles.style10NormalLightGrey
          : AppTextStyles.style12BoldLightGrey,
    );
  }

  RatingBarIndicator _ratingStars(
      Product product, Color starColor, BuildContext context) {
    return RatingBarIndicator(
      rating: product.rating?.toDouble() ?? 0,
      itemBuilder: (context, index) =>
          Icon(Icons.star_rounded, color: starColor),
      itemCount: 5,
      itemSize: ResponsiveLayout.isMobile(context) ? 20.0 : 30.0,
      direction: Axis.horizontal,
    );
  }

  Text _ratingNumber(Product product) {
    return Text(
      product.rating?.toString() ?? "No rating",
      style:
          AppTextStyles.style20Bold.copyWith(color: AppColors.foregroundColor),
    );
  }

  Text _title(BuildContext context) {
    return Text('Overall Rating',
        style: ResponsiveLayout.isMobile(context)
            ? AppTextStyles.style14W600
            : AppTextStyles.style16Bold);
  }
}
