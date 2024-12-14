import 'package:bazaar/core/utils/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/functions/is_arabic.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_text_styles.dart';
import '../../../../../domain/entities/home_categories_entity.dart';

class HomeAllCategoriesBodyDesktop extends StatelessWidget {
  const HomeAllCategoriesBodyDesktop({
    super.key,
    required this.categoriesList,
    required this.scrollController,
  });

  final List<HomeCategoriesEntity> categoriesList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ListView.builder(
        controller: scrollController,
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categoriesList[index];
          return InkWell(
            onTap: () {
              context.goNamed(
                AppRouter.category,
                pathParameters: {'slug': category.slug!},
                extra: isArabic(context)
                    ? category.localizedTitle!.ar!
                    : category.localizedTitle!.en!,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      imageUrl: category.imageUrl!,
                    ),
                  ),
                ),
                Text(
                  isArabic(context)
                      ? category.localizedTitle!.ar!
                      : category.localizedTitle!.en!,
                  style: AppTextStyles.style12BoldLightGrey
                      .copyWith(color: AppColors.foregroundColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
