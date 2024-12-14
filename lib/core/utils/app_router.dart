import 'package:bazaar/features/auth/presentation/views/auth_view.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/cart_view.dart';
import 'package:bazaar/features/cart/presentation/views/checkout_view.dart';
import 'package:bazaar/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:bazaar/features/home/presentation/views/category_view.dart';
import 'package:bazaar/features/profile/presentation/views/profile_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/home_view.dart';
import '../../features/product/presentation/views/product_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String splash = '/';
  static const String home = '/bazaar';
  static const String auth = '/auth';
  static const String category = '/category/:slug';
  static const String product = '/:productTitle/:productId';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String wishlist = '/wishlist';

  static final GoRouter appRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRouter.splash,
        name: AppRouter.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRouter.auth,
        name: AppRouter.auth,
        builder: (context, state) => const AuthView(),
      ),
      GoRoute(
        path: AppRouter.home,
        name: AppRouter.home,
        builder: (context, state) => const HomeView(),
        routes: [
          GoRoute(
            path: AppRouter.category,
            name: AppRouter.category,
            builder: (context, state) {
              final String slug = state.pathParameters['slug'] ?? '';
              final title = state.extra.toString();

              return CategoryView(slug: slug, categoryTitle: title);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRouter.product,
        name: AppRouter.product,
        builder: (context, state) {
          state.pathParameters['productTitle'] ?? '';
          final String productId = state.pathParameters['productId'] ?? '';
          return ProductView(
            productId: productId,
          );
        },
      ),
      // GoRoute(
      //   path: AppRouter.search,
      //   name: AppRouter.search,
      //   pageBuilder: (context, state) => CustomTransitionPage(
      //     child: const SearchView(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       const begin = Offset(0.0, 1.0); // Start from the bottom
      //       const end = Offset.zero; // End at the current position
      //       const curve = Curves.easeInOut;

      //       final tween = Tween(begin: begin, end: end).chain(
      //         CurveTween(curve: curve),
      //       );

      //       final offsetAnimation = animation.drive(tween);

      //       return SlideTransition(
      //         position: offsetAnimation,
      //         child: child,
      //       );
      //     },
      //   ),
      // ),
      GoRoute(
        path: AppRouter.wishlist,
        name: AppRouter.wishlist,
        builder: (context, state) => const WishlistView(),
      ),
      GoRoute(
        path: AppRouter.profile,
        name: AppRouter.profile,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: AppRouter.cart,
        name: AppRouter.cart,
        builder: (context, state) => const CartView(),
      ),
      GoRoute(
        path: AppRouter.checkout,
        name: AppRouter.checkout,
        builder: (context, state) {
          final CartSuccess successState = state.extra as CartSuccess;
          return CheckoutView(successState: successState);
        },
      ),
    ],
  );
}
