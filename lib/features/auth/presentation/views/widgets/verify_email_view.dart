import 'dart:async';

import 'package:bazaar/core/services/get_it_service.dart';
import 'package:bazaar/core/widget/custom_snack_bar.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/verify_email_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../generated/locale_keys.g.dart';

class VerifyEmailView extends StatefulWidget {
  final PageController signUpAndVerifyEmailController;
  final TextEditingController emailController;
  const VerifyEmailView(
      {super.key,
      required this.signUpAndVerifyEmailController,
      required this.emailController});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late Timer? timer;

  @override
  void initState() {
    super.initState();

    // Check every 3 seconds if the email has been verified
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        if (await getIt<FirebaseAuthService>().checkEmailVerification() &&
            mounted) {
          timer.cancel(); // Stop the timer
          showSuccessSnackBar(
              context: context,
              sucMessage: LocaleKeys.auth_email_verified_successfully.tr());
          GoRouter.of(context).pushReplacement(AppRouter.home);
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VerifyEmailViewBody(
      signUpAndVerifyEmailController: widget.signUpAndVerifyEmailController,
      emailController: widget.emailController,
    );
  }
}
