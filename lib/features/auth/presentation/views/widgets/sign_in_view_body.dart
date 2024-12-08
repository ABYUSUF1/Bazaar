import 'package:bazaar/core/services/get_it_service.dart';
import 'package:bazaar/core/utils/app_router.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/widget/custom_snack_bar.dart';
import 'package:bazaar/features/auth/presentation/manager/sign_in/sign_in_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../domain/repo/auth_repo.dart';
import 'auth_social_buttons.dart';
import 'custom_or_divider.dart';
import 'custom_text_form_field.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.authPageController,
    required this.signInAndForgetPasswordController,
    required this.signInFormKey,
  });

  final PageController authPageController;
  final PageController signInAndForgetPasswordController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> signInFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signInFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildSignInHeader(),
              const SizedBox(height: 30),
              const AuthSocialButtons(), // Google and Facebook buttons
              const SizedBox(height: 30),
              const CustomOrDivider(), // Or divider
              const SizedBox(height: 30),
              _buildEmailField(),
              const SizedBox(height: 15),
              _buildPasswordField(),
              _buildForgotPasswordButton(),
              const SizedBox(height: 60),
              _buildSignInButton(),
              const SizedBox(height: 10),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInHeader() {
    return Column(
      children: [
        Text(LocaleKeys.auth_sign_in.tr(), style: AppTextStyles.style20Bold),
        const SizedBox(height: 5),
        Text(LocaleKeys.auth_sign_in_desc.tr(),
            style: AppTextStyles.style12BoldLightGrey),
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextFormField(
      title: LocaleKeys.auth_email_address.tr(),
      controller: emailController,
      validator: (value) =>
          AuthValidator.validateEmail(emailController.text.trim()),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextFormField(
      title: LocaleKeys.auth_password.tr(),
      controller: passwordController,
      validator: (value) =>
          AuthValidator.validatePassword(passwordController.text.trim()),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          signInAndForgetPasswordController.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          LocaleKeys.auth_forgot_password.tr(),
          style: AppTextStyles.style12BoldLightGrey
              .copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return BlocProvider(
      create: (context) => SignInCubit(getIt<AuthRepo>()),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            showErrorSnackBar(context: context, errMessage: state.errMessage);
          } else if (state is SignInSuccess) {
            GoRouter.of(context).pushReplacement(AppRouter.home);
          }
        },
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              if (signInFormKey.currentState!.validate()) {
                context.read<SignInCubit>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: state is SignInLoading
                ? const SizedBox.square(
                    dimension: 17,
                    child: CircularProgressIndicator(
                      color: AppColors.whiteColor,
                    ),
                  )
                : Text(LocaleKeys.auth_sign_in.tr()),
          );
        },
      ),
    );
  }

  Widget _buildSignUpButton() {
    return TextButton(
      onPressed: () {
        authPageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      )),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.auth_dont_have_an_account.tr(),
              style: AppTextStyles.style12Normal,
            ),
            TextSpan(
                text: '  ${LocaleKeys.auth_sign_up.tr()}',
                style: AppTextStyles.style12BoldLightGrey.copyWith(
                  color: AppColors.primaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
