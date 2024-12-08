import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/verify_email_button.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';

class VerifyEmailViewBody extends StatelessWidget {
  final PageController signUpAndVerifyEmailController;
  final TextEditingController emailController;
  const VerifyEmailViewBody(
      {super.key,
      required this.signUpAndVerifyEmailController,
      required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeaderText(),
          _buildImage(),
          const VerifyEmailButton()
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SvgPicture.asset(
      AppAssets.imagesIconsVerifyEmail,
      width: 150,
      height: 150,
    );
  }

  Widget _buildHeaderText() {
    return Column(
      children: [
        Text(LocaleKeys.auth_verify_email.tr(),
            style: AppTextStyles.style20Bold),
        const SizedBox(height: 5),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                  text: LocaleKeys.auth_an_email_has_been_sent_to.tr(),
                  style: AppTextStyles.style12BoldLightGrey),
              TextSpan(
                  text: emailController.text.trim(),
                  style: AppTextStyles.style12BoldLightGrey
                      .copyWith(color: AppColors.primaryColor)),
              TextSpan(
                  text: LocaleKeys
                      .auth_with_a_link_to_verify_your_account_check_your_spam_folder_if_it_doesnt_appear_within_a_minute
                      .tr(),
                  style: AppTextStyles.style12BoldLightGrey),
            ],
          ),
        )
      ],
    );
  }
}
