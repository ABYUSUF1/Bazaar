import 'package:bazaar/features/search/presentation/views/widgets/search_list.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text("View Body"),
      ),
    );
  }
}
