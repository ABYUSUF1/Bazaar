import 'package:bazaar/core/services/firebase/firestore_service.dart';
import 'package:bazaar/features/cart/data/repo_imple/cart_repo_imple.dart';
import 'package:bazaar/features/favorite/data/favorite_repo_imple/favorite_repo_imple.dart';
import 'package:bazaar/features/favorite/domain/favorite_repo/favorite_repo.dart';
import 'package:bazaar/features/product/data/repo_imple/product_repo_imple.dart';
import 'package:bazaar/features/product/domain/repo/product_repo.dart';
import 'package:bazaar/features/profile/data/repo_imple/profile_repo_imple.dart';
import 'package:bazaar/features/profile/domain/repo/profile_repo.dart';
import 'package:bazaar/features/search/data/search_repo_imple/search_repo_imple.dart';
import 'package:bazaar/features/search/domain/search_repo/search_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo_imple/auth_repo_imple.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../../features/cart/domain/repo/cart_repo.dart';
import '../../features/home/data/home_repo_imple/home_repo_imple.dart';
import '../../features/home/domain/home_repo/home_repo.dart';
import '../api/dio_api_client.dart';
import 'firebase/firebase_auth_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  getIt
      .registerSingleton<ProfileRepo>(ProfileRepoImple(AuthFirestoreService()));

  getIt.registerSingleton<AuthRepo>(AuthRepoImple(getIt<FirebaseAuthService>(),
      AuthFirestoreService(), getIt<ProfileRepo>()));

  getIt.registerSingleton<HomeRepo>(HomeRepoImple(DioApiClient(Dio())));

  getIt.registerSingleton<ProductRepo>(ProductRepoImple(DioApiClient(Dio())));

  getIt.registerSingleton<CartRepo>(CartRepoImple(CartFirestoreService()));

  getIt.registerSingleton<SearchRepo>(SearchRepoImple(DioApiClient(Dio())));

  getIt.registerSingleton<FavoriteRepo>(
      FavoriteRepoImple(WishlistFirestoreService(), FirebaseAuthService()));
}
