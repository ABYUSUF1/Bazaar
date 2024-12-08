import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/auth/presentation/manager/sign_up/sign_up_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../core/widget/custom_snack_bar.dart';
import '../../../domain/repo/auth_repo.dart';
import 'auth_social_buttons.dart';
import 'custom_or_divider.dart';
import 'custom_text_form_field.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.signInAndSignUpController,
    required this.signUpFormKey,
    required this.signUpAndVerifyEmailController,
  });

  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final PageController signInAndSignUpController;
  final PageController signUpAndVerifyEmailController;
  final GlobalKey<FormState> signUpFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildSignUpHeader(),
            const SizedBox(height: 30),
            const AuthSocialButtons(), // Google and Facebook buttons
            const SizedBox(height: 30),
            const CustomOrDivider(), // Or divider
            const SizedBox(height: 15),
            _buildNameField(),
            const SizedBox(height: 15),
            _buildEmailField(),
            const SizedBox(height: 15),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 25),
            _buildTermsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpHeader() {
    return Column(
      children: [
        Text(
          LocaleKeys.auth_create_account.tr(),
          style: AppTextStyles.style20Bold,
        ),
        const SizedBox(height: 5),
        Text(
          LocaleKeys.auth_sign_up_desc.tr(),
          style: AppTextStyles.style12BoldLightGrey,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return CustomTextFormField(
      title: LocaleKeys.auth_username.tr(),
      controller: nameController,
      validator: (value) => AuthValidator.validateUsername(value?.trim() ?? ''),
    );
  }

  Widget _buildEmailField() {
    return CustomTextFormField(
      title: LocaleKeys.auth_email_address.tr(),
      controller: emailController,
      validator: (value) => AuthValidator.validateEmail(value?.trim() ?? ''),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextFormField(
      title: LocaleKeys.auth_password.tr(),
      controller: passwordController,
      validator: (value) => AuthValidator.validatePassword(value?.trim() ?? ''),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSignUpButton(),
        _buildSignInButton(),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt<AuthRepo>()),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            showErrorSnackBar(context: context, errMessage: state.errMessage);
          } else if (state is SignUpSuccess) {
            signUpAndVerifyEmailController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            showSuccessSnackBar(
                context: context,
                sucMessage: LocaleKeys.auth_verify_email_send.tr());
          }
        },
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              signUpFormKey.currentState!.save();
              if (signUpFormKey.currentState!.validate()) {
                context.read<SignUpCubit>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: state is SignUpLoading
                ? const SizedBox.square(
                    dimension: 17,
                    child:
                        CircularProgressIndicator(color: AppColors.whiteColor),
                  )
                : Text(LocaleKeys.auth_sign_up.tr()),
          );
        },
      ),
    );
  }

  Widget _buildSignInButton() {
    return TextButton(
      onPressed: () {
        signInAndSignUpController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.auth_have_an_account.tr(),
              style: AppTextStyles.style12Normal,
            ),
            TextSpan(
                text: '\n${LocaleKeys.auth_sign_in.tr()}',
                style: AppTextStyles.style12BoldLightGrey.copyWith(
                  color: AppColors.primaryColor,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return Text(
      LocaleKeys.auth_terms_and_policies.tr(),
      style: AppTextStyles.style10NormalLightGrey,
      textAlign: TextAlign.center,
    );
  }
}
