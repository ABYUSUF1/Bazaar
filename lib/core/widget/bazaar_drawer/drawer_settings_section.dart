import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_text_styles.dart';
import '../custom_list_tile.dart';

class DrawerSettingsSection extends StatelessWidget {
  const DrawerSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Settings", style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        const Column(children: [
          CustomListTile(
              title: "Language", svgIcon: AppAssets.imagesIconsLanguage),
          CustomListTile(
              title: "Location", svgIcon: AppAssets.imagesIconsLocation),
        ]),
      ],
    );
  }
}
