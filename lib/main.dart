import 'package:bazaar/core/themes/light_theme.dart';
import 'package:bazaar/features/cart/domain/repo/cart_repo.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/favorite/domain/favorite_repo/favorite_repo.dart';
import 'package:bazaar/features/favorite/presentation/manager/favorite/favorite_cubit.dart';
import 'package:bazaar/features/profile/domain/repo/profile_repo.dart';
import 'package:bazaar/features/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:bazaar/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:bazaar/firebase_options.dart';
import 'package:bazaar/generated/codegen_loader.g.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/get_it_service.dart';
import 'core/utils/app_router.dart';
import 'features/home/domain/home_repo/home_repo.dart';
import 'features/home/presentation/manager/get_all_categories/get_all_categories_cubit.dart';
import 'features/search/domain/search_repo/search_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupGetIt();

  runApp(EasyLocalization(
    supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
    path: 'assets/localization/',
    assetLoader: const CodegenLoader(),
    // In first i was adding languages but i realized that the api only have english
    startLocale: const Locale('en'),
    child: DevicePreview(builder: (context) {
      return const BazaarApp();
    }),
  ));
}

class BazaarApp extends StatelessWidget {
  const BazaarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit(getIt<CartRepo>())),
        BlocProvider(create: (context) => ProfileCubit(getIt<ProfileRepo>())),
        BlocProvider(create: (context) {
          final cubit = GetAllCategoriesCubit(getIt<HomeRepo>());
          cubit.getAllCategories();
          return cubit;
        }),
        BlocProvider(
          create: (context) => SearchCubit(getIt<SearchRepo>()),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(getIt<FavoriteRepo>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bazaar',
        theme: lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routeInformationParser: AppRouter.appRouter.routeInformationParser,
        routeInformationProvider: AppRouter.appRouter.routeInformationProvider,
        routerDelegate: AppRouter.appRouter.routerDelegate,
      ),
    );
  }
}

//! Some updates need to do
//  صلي الاول

//* Deal with Loading !!!!