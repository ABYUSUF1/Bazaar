import 'package:bazaar/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../../core/utils/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _splashOperations();
  }

  _splashOperations() async {
    await Future.delayed(const Duration(seconds: 5));
    bool isLoggedIn = await getIt<FirebaseAuthService>().isUserLoggedIn();
    if (!mounted) return;
    if (isLoggedIn) {
      GoRouter.of(context).pushReplacement(AppRouter.home);
    } else {
      GoRouter.of(context).pushReplacement(AppRouter.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppAssets.lottiesBazaarSplashAnimation,
          width: 300,
          height: 300,
          repeat: false,
        ),
      ),
    );
  }
}
