import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/utils/models/products_details_model/review.dart';

class RatingBreakdown extends StatelessWidget {
  final List<Review> reviews;
  final Color Function(double?) getColorForRating;

  const RatingBreakdown(
      {super.key, required this.reviews, required this.getColorForRating});

  List<int> _calculateRatingCounts() {
    final ratingCounts = List<int>.filled(5, 0);
    for (var review in reviews) {
      if (review.rating != null) {
        ratingCounts[review.rating! - 1]++;
      }
    }
    return ratingCounts;
  }

  double _calculatePercentage(int rating) {
    if (reviews.isEmpty) return 0;
    final ratingCounts = _calculateRatingCounts();
    return ratingCounts[rating - 1] / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int rating = 5; rating >= 1; rating--) ...[
          _buildRatingRow(rating, context),
          SizedBox(height: ResponsiveLayout.isMobile(context) ? 2 : 8),
        ],
      ],
    );
  }

  Widget _buildRatingRow(int rating, BuildContext context) {
    final percentage = _calculatePercentage(rating);
    return Row(
      children: [
        SizedBox(
          width: 10,
          child: Text("$rating",
              style: ResponsiveLayout.isMobile(context)
                  ? AppTextStyles.style12Normal
                      .copyWith(fontWeight: FontWeight.w600)
                  : AppTextStyles.style14W600),
        ),
        const SizedBox(width: 5),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            color: getColorForRating(rating.toDouble()),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 40,
          child: Text(
            "${(percentage * 100).toStringAsFixed(0)}%",
            style: ResponsiveLayout.isMobile(context)
                ? AppTextStyles.style12Normal
                    .copyWith(fontWeight: FontWeight.w600)
                : AppTextStyles.style14W600,
          ),
        ),
      ],
    );
  }
}
