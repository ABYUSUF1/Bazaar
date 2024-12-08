import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Personalization", style: AppTextStyles.style14W600),
        ),
        const SizedBox(height: 10),
        const Column(children: [
          CustomListTile(
              title: "Notification", svgIcon: AppAssets.imagesIconsOrders),
          DarkModeToggle(),
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
  String get _toggleText => _isDarkMode ? "Dark Mode" : "Light Mode";
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
