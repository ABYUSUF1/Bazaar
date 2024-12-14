import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../functions/is_arabic.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';
import '../custom_list_tile.dart';
import '../restart_widget.dart';

class DrawerSettingsSection extends StatelessWidget {
  const DrawerSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(LocaleKeys.home_settings.tr(),
              style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        Column(children: [
          CustomListTile(
            title: LocaleKeys.home_language.tr(),
            svgIcon: AppAssets.imagesIconsLanguage,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(LocaleKeys.home_language.tr()),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('العربية'),
                          trailing: isArabic(context)
                              ? const Icon(Icons.check_circle,
                                  color: AppColors.successColor)
                              : const SizedBox.shrink(),
                          onTap: () {
                            EasyLocalization.of(context)!
                                .setLocale(const Locale('ar'));

                            RestartWidget.restartApp(context);
                          },
                        ),
                        ListTile(
                          title: const Text('English'),
                          trailing: isArabic(context)
                              ? const SizedBox.shrink()
                              : const Icon(Icons.check_circle,
                                  color: AppColors.successColor),
                          onTap: () {
                            EasyLocalization.of(context)!
                                .setLocale(const Locale('en'));

                            RestartWidget.restartApp(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          CustomListTile(
              title: LocaleKeys.home_location.tr(),
              svgIcon: AppAssets.imagesIconsLocation),
        ]),
      ],
    );
  }
}
