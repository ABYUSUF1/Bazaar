import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/forget_password_send_button.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/auth_validator.dart';
import 'custom_text_form_field.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({
    super.key,
    required this.signInAndForgetPasswordController,
    required this.emailController,
    required this.forgetPasswordFormKey,
  });

  final PageController signInAndForgetPasswordController;
  final TextEditingController emailController;
  final GlobalKey<FormState> forgetPasswordFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgetPasswordFormKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            const SizedBox(height: 50),
            _buildHeaderText(),
            const SizedBox(height: 50),
            _buildEmailField(),
            const SizedBox(height: 50),
            ForgetPasswordSendButton(
                emailController: emailController,
                forgetPasswordFormKey: forgetPasswordFormKey)
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return TextButton.icon(
      onPressed: () {
        signInAndForgetPasswordController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      label: Text(LocaleKeys.common_back.tr(),
          style: AppTextStyles.style14Normal
              .copyWith(color: AppColors.foregroundColor2)),
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 14,
        color: AppColors.foregroundColor2,
      ),
    );
  }

  Widget _buildHeaderText() {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(LocaleKeys.auth_forgot_password.tr(),
              style: AppTextStyles.style20Bold),
          const SizedBox(height: 5),
          Text(LocaleKeys.auth_forget_password_desc.tr(),
              style: AppTextStyles.style12BoldLightGrey),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextFormField(
      title: LocaleKeys.auth_email_address.tr(),
      controller: emailController,
      validator: (value) => AuthValidator.validateEmail(value?.trim() ?? ''),
    );
  }
}
