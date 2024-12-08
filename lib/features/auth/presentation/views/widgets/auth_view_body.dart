import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/sign_up_view.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import 'sign_in_view.dart';

class AuthViewBody extends StatefulWidget {
  const AuthViewBody({super.key});

  @override
  State<AuthViewBody> createState() => _AuthViewBodyState();
}

class _AuthViewBodyState extends State<AuthViewBody> {
  final PageController signInAndSignUpController = PageController();

  @override
  void dispose() {
    signInAndSignUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: ResponsiveLayout.isMobile(context) ? 340 : 400,
          height: 600,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.2),
                spreadRadius: 40,
                blurRadius: 40,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: PageView(
            controller: signInAndSignUpController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              SignInView(signInAndSignUpController: signInAndSignUpController),
              SignUpView(signInAndSignUpController: signInAndSignUpController),
            ],
          ),
        ),
      ),
    );
  }
}
