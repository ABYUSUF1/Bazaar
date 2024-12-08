import 'package:flutter/material.dart';

import '../../../../../../core/utils/responsive_layout.dart';
import 'home_ads.dart';
import 'home_all_categories/home_all_categories.dart';
import 'home_popular_products.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Home's Ads
        const HomeAds(),

        _space(context),

        // Home's Categories
        const HomeAllCategories(),

        _space(context),

        // Home's Popular Products
        const HomePopularProducts(),

        _space(context),
      ],
    );
  }

  SizedBox _space(BuildContext context) {
    return SizedBox(height: ResponsiveLayout.isDesktop(context) ? 40 : 30);
  }
}
