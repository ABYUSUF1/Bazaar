import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../functions/is_arabic.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';
import '../custom_list_tile.dart';

class DrawerHelpAndSupportSection extends StatelessWidget {
  const DrawerHelpAndSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: isArabic(context) ? 0.0 : 16.0,
              right: isArabic(context) ? 16.0 : 0.0),
          child: Text(LocaleKeys.home_help_support.tr(),
              style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        Column(children: [
          CustomListTile(
              title: LocaleKeys.home_contact_us.tr(),
              svgIcon: AppAssets.imagesIconsContactUs),
          CustomListTile(
              title: LocaleKeys.home_faqs.tr(),
              svgIcon: AppAssets.imagesIconsFaqs),
        ]),
      ],
    );
  }
}
