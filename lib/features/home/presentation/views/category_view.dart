import 'package:bazaar/core/services/get_it_service.dart';
import 'package:bazaar/core/widget/custom_scaffold.dart';
import 'package:bazaar/features/home/domain/home_repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/get_all_category_products/get_all_category_products_cubit.dart';
import 'widgets/category_view_widgets/category_view_body.dart';

class CategoryView extends StatelessWidget {
  final String slug;
  final String categoryTitle;
  const CategoryView(
      {super.key, required this.slug, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: BlocProvider(
      create: (context) {
        final cubit = GetAllCategoryProductsCubit(getIt<HomeRepo>());
        cubit.getAllCategoryProducts(categorySlug: slug);
        return cubit;
      },
      child: CategoryViewBody(
        categoryTitle: categoryTitle,
      ),
    ));
  }
}
