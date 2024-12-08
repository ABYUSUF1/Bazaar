import 'package:flutter/material.dart';

import 'forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  final PageController signInAndForgetPasswordController;
  final TextEditingController emailController;
  final GlobalKey<FormState> forgetPasswordFormKey;
  const ForgetPasswordView(
      {super.key,
      required this.signInAndForgetPasswordController,
      required this.emailController,
      required this.forgetPasswordFormKey});

  @override
  Widget build(BuildContext context) {
    return ForgetPasswordViewBody(
      signInAndForgetPasswordController: signInAndForgetPasswordController,
      emailController: emailController,
      forgetPasswordFormKey: forgetPasswordFormKey,
    );
  }
}
