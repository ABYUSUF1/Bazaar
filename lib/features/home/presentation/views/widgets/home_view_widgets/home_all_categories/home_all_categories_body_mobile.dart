import 'package:bazaar/core/functions/is_arabic.dart';
import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_router.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/widget/scroll_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../domain/entities/home_categories_entity.dart';

class HomeAllCategoriesBodyMobile extends StatelessWidget {
  final List<HomeCategoriesEntity> categoriesList;
  final ScrollController scrollController;

  const HomeAllCategoriesBodyMobile(
      {super.key,
      required this.categoriesList,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 215,
          alignment: Alignment.bottomCenter,
          child: GridView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 10.0, // Space between columns
            ),
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              final category = categoriesList[index];
              return InkWell(
                onTap: () {
                  context.goNamed(AppRouter.category,
                      pathParameters: {'slug': category.slug!},
                      extra: isArabic(context)
                          ? category.localizedTitle!.ar!
                          : category.localizedTitle!.en!);
                },
                child: Column(
                  children: [
                    ClipOval(
                        child: CachedNetworkImage(
                      imageUrl: category.imageUrl!,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    )),
                    Expanded(
                      child: Text(
                        isArabic(context)
                            ? category.localizedTitle!.ar!
                            : category.localizedTitle!.en!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.style12BoldLightGrey
                            .copyWith(color: AppColors.foregroundColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        ScrollIndicator(
          scrollController: scrollController,
          width: 50,
          height: 5,
          indicatorWidth: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
          indicatorDecoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }
}
