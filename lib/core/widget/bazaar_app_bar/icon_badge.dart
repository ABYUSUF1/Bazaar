import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconBadge extends StatelessWidget {
  final String svgIcon;
  final int? badgeCount;
  final String? labelText;
  final void Function()? onPressed;

  const CustomIconBadge({
    super.key,
    required this.svgIcon,
    this.badgeCount,
    this.labelText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: Row(
        children: [
          IconButton(
              onPressed: onPressed,
              tooltip: labelText,
              icon: Badge.count(
                count: badgeCount!,
                backgroundColor: AppColors.primaryColor,
                isLabelVisible: badgeCount == 0 ? false : true,
                child: SvgPicture.asset(svgIcon, width: 22, height: 22),
              )),
          ResponsiveLayout.isDesktop(context)
              ? Text(labelText!, style: AppTextStyles.style14Normal)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
