import 'package:bazaar/core/widget/title_widget.dart';
import 'package:flutter/material.dart';

class HomeBestSellingProducts extends StatelessWidget {
  const HomeBestSellingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleWidget(title: 'Best Selling'),
      ],
    );
  }
}
