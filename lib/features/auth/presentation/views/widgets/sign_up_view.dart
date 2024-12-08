import 'package:flutter/material.dart';

import 'sign_up_view_body.dart';
import 'verify_email_view.dart';

class SignUpView extends StatefulWidget {
  final PageController signInAndSignUpController;
  const SignUpView({super.key, required this.signInAndSignUpController});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final PageController signUpAndVerifyEmailController = PageController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    signUpAndVerifyEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: signUpAndVerifyEmailController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SignUpViewBody(
            signInAndSignUpController: widget.signInAndSignUpController,
            emailController: emailController,
            nameController: nameController,
            passwordController: passwordController,
            signUpFormKey: signUpFormKey,
            signUpAndVerifyEmailController: signUpAndVerifyEmailController,
          ),
          VerifyEmailView(
            signUpAndVerifyEmailController: signUpAndVerifyEmailController,
            emailController: emailController,
          )
        ]);
  }
}
