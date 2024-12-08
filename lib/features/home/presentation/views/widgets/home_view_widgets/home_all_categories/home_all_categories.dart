import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/core/widget/title_widget.dart';
import 'package:bazaar/features/home/presentation/manager/get_all_categories/get_all_categories_cubit.dart';
import 'package:bazaar/features/home/presentation/views/widgets/home_view_widgets/home_all_categories/home_all_categories_body_desktop.dart';
import 'package:bazaar/features/home/presentation/views/widgets/home_view_widgets/home_all_categories/home_all_categories_body_mobile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../domain/entities/home_categories_entity.dart';

class HomeAllCategories extends StatefulWidget {
  const HomeAllCategories({super.key});

  @override
  State<HomeAllCategories> createState() => _HomeAllCategoriesState();
}

class _HomeAllCategoriesState extends State<HomeAllCategories> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleWidget(
          title: LocaleKeys.home_categories.tr(),
          displayDirectionButtons: true,
          scrollController: scrollController,
        ),
        // SizedBox(height: ResponsiveLayout.isMobile(context) ? 7 : 20),
        _HomeAllCategoriesList(scrollController: scrollController),
      ],
    );
  }
}

class _HomeAllCategoriesList extends StatelessWidget {
  final ScrollController scrollController;
  const _HomeAllCategoriesList({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllCategoriesCubit, GetAllCategoriesState>(
      builder: (context, state) {
        final List<HomeCategoriesEntity> categoriesList = [];

        if (state is GetAllCategoriesSuccess) {
          categoriesList.addAll(state.categoriesList);
        }

        return ResponsiveLayout.isMobile(context)
            ? HomeAllCategoriesBodyMobile(
                categoriesList: categoriesList,
                scrollController: scrollController)
            : HomeAllCategoriesBodyDesktop(
                categoriesList: categoriesList,
                scrollController: scrollController,
              );
      },
    );
  }
}
