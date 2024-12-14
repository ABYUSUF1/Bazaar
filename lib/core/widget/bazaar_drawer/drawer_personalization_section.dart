import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../functions/is_arabic.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';
import '../custom_list_tile.dart';

class DrawerPersonalizationSection extends StatelessWidget {
  const DrawerPersonalizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: isArabic(context) ? 0.0 : 16.0,
              right: isArabic(context) ? 16.0 : 0.0),
          child: Text(LocaleKeys.home_personalization.tr(),
              style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        Column(children: [
          CustomListTile(
              title: LocaleKeys.home_notifications.tr(),
              svgIcon: AppAssets.imagesIconsOrders),
          const DarkModeToggle(),
        ]),
      ],
    );
  }
}

class DarkModeToggle extends StatefulWidget {
  const DarkModeToggle({super.key});

  @override
  State<DarkModeToggle> createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool _isDarkMode = false;
  String get _toggleText => _isDarkMode
      ? LocaleKeys.home_dark_mode.tr()
      : LocaleKeys.home_light_mode.tr();
  String get _toggleIcon => _isDarkMode
      ? AppAssets.imagesIconsDarkMode
      : AppAssets.imagesIconsLightMode;
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
        title: _toggleText,
        svgIcon: _toggleIcon,
        trailingChild: Switch(
          value: _isDarkMode,
          onChanged: _toggleDarkMode,
          activeColor: Colors.blue, // Customize the active color
        ));
  }
}
