import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_text_styles.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String svgIcon;
  final Widget? besideTitleChild;
  final Widget? trailingChild;
  final void Function()? onTap;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.svgIcon,
      this.besideTitleChild,
      this.trailingChild,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(svgIcon, width: 20, height: 20),
      title: Row(
        children: [
          Text(title, style: AppTextStyles.style14Normal),
          if (besideTitleChild != null) const SizedBox(width: 20),
          besideTitleChild ?? const SizedBox.shrink(),
        ],
      ),
      trailing: trailingChild ??
          const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey),
    );
  }
}
