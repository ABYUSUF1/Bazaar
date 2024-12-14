import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../generated/locale_keys.g.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  const SearchTextField({super.key, required this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: LocaleKeys.home_search_hint.tr(),
        hintStyle:
            AppTextStyles.style14Normal.copyWith(color: AppColors.greyColor),
        filled: true,
        suffixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
        fillColor: AppColors.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
      ),
    );
  }
}
