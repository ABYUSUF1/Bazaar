import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';

class CustomOrDivider extends StatelessWidget {
  const CustomOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.secondaryColor),
        ),
        const SizedBox(width: 18),
        Text(LocaleKeys.common_or.tr(), style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 18),
        const Expanded(
          child: Divider(color: AppColors.secondaryColor),
        ),
      ],
    );
  }
}
