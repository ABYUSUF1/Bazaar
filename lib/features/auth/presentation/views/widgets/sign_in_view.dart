import 'package:bazaar/features/auth/presentation/views/widgets/forget_password_view.dart';
import 'package:flutter/material.dart';

import 'sign_in_view_body.dart';

class SignInView extends StatefulWidget {
  final PageController signInAndSignUpController;
  const SignInView({super.key, required this.signInAndSignUpController});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  final PageController signInAndForgetPasswordController = PageController();

  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    signInAndForgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: signInAndForgetPasswordController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SignInViewBody(
            authPageController: widget.signInAndSignUpController,
            signInAndForgetPasswordController:
                signInAndForgetPasswordController,
            emailController: emailController,
            passwordController: passwordController,
            signInFormKey: signInFormKey,
          ),
          ForgetPasswordView(
            signInAndForgetPasswordController:
                signInAndForgetPasswordController,
            emailController: emailController,
            forgetPasswordFormKey: forgetPasswordFormKey,
          )
        ]);
  }
}
