import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/core/widget/title_widget.dart';
import 'package:bazaar/features/product/presentation/views/widgets/overview/rating_overview.dart';
import 'package:bazaar/features/product/presentation/views/widgets/overview/review_overview.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/responsive_layout.dart';

class ProductRatingAndReview extends StatelessWidget {
  final ProductsDetailsEntity productDetails;
  const ProductRatingAndReview({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        const TitleWidget(title: 'Overview', displayViewAllButton: false),
        const SizedBox(height: 10),
        Container(
            padding:
                EdgeInsets.all(ResponsiveLayout.isMobile(context) ? 10 : 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.foregroundColor2)),
            child: width > 800
                ? _ProductRatingAndReviewDesktop(productDetails: productDetails)
                : _ProductRatingAndReviewMobile(productDetails: productDetails))
      ],
    );
  }
}

class _ProductRatingAndReviewDesktop extends StatelessWidget {
  const _ProductRatingAndReviewDesktop({
    required this.productDetails,
  });

  final ProductsDetailsEntity productDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall Rating
        Expanded(
            flex: 2, child: RatingOverview(productsDetails: productDetails)),

        Container(
          width: 1,
          height: 300,
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
        ),

        // Review
        Expanded(
            flex: 4, child: ReviewOverview(productsDetails: productDetails)),
      ],
    );
  }
}

class _ProductRatingAndReviewMobile extends StatelessWidget {
  const _ProductRatingAndReviewMobile({
    required this.productDetails,
  });

  final ProductsDetailsEntity productDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall Rating
        RatingOverview(productsDetails: productDetails),
        const SizedBox(height: 25),
        // Review
        ReviewOverview(productsDetails: productDetails),
      ],
    );
  }
}
