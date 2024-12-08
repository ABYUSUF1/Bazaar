import 'package:bazaar/core/functions/get_color_for_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/utils/entities/products_details_entity.dart';
import '../../../../../../core/utils/models/products_details_model/review.dart';

class ReviewOverview extends StatelessWidget {
  final ProductsDetailsEntity productsDetails;
  const ReviewOverview({super.key, required this.productsDetails});

  @override
  Widget build(BuildContext context) {
    final product = productsDetails.products!.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${product.reviews!.length} Reviews',
                style: AppTextStyles.style16Bold),
          ],
        ),
        Divider(color: Colors.grey.shade300),
        CommentSection(reviews: product.reviews!),
        const SizedBox(height: 5),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
            child: Text(
              "View All Reviews",
              style: AppTextStyles.style14W600
                  .copyWith(color: AppColors.primaryColor),
            ))
      ],
    );
  }
}

class CommentSection extends StatelessWidget {
  final List<Review> reviews;
  const CommentSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Text('No reviews available.', style: AppTextStyles.style12Normal);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        reviews.take(3).length, // Show only the first 3 reviews
        (index) {
          final review = reviews[index];
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text(
                      getInitials(review.reviewerName),
                      style: AppTextStyles.style14W600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.reviewerName ?? 'Anonymous',
                          style: AppTextStyles.style14W600,
                        ),
                        Text(
                          formatDate(
                            review.date?.toIso8601String() ??
                                DateTime.now().toIso8601String(),
                          ),
                          style: AppTextStyles.style10NormalLightGrey,
                        ),
                        const SizedBox(height: 5),
                        RatingBarIndicator(
                          rating: review.rating?.toDouble() ?? 0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: getColorForRating(review.rating?.toDouble()),
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          review.comment ?? '',
                          style: AppTextStyles.style12Normal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Colors.grey.shade300, height: 1),
              )
            ],
          );
        },
      ),
    );
  }

  String getInitials(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return '';
    }
    List<String> names = fullName.split(' ');
    String initials = '';
    for (String name in names) {
      if (name.isNotEmpty) {
        initials += name[0];
      }
    }
    return initials.toUpperCase();
  }

  String formatDate(String apiDate) {
    DateTime dateTime = DateTime.parse(apiDate);
    return DateFormat('d MMMM y').format(dateTime);
  }
}
