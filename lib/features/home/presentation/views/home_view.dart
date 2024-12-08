import 'package:bazaar/core/widget/custom_scaffold.dart';
import 'package:bazaar/features/home/presentation/manager/get_popular_products/get_popular_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../profile/presentation/manager/profile/profile_cubit.dart';
import '../../domain/home_repo/home_repo.dart';
import 'widgets/home_view_widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocProvider(
        create: (context) {
          final cubit = GetPopularProductsCubit(getIt<HomeRepo>());
          cubit.getPopularProducts();

          context
              .read<ProfileCubit>()
              .loadUserData(getIt<FirebaseAuthService>().getUserId());

          // context.read<CartCubit>().getCartItems();

          // context.read<FavoriteCubit>().loadFavorites();
          return cubit;
        },
        child: const HomeViewBody(),
      ),
    );
  }
}
