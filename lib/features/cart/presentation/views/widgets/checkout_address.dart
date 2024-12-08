import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widget/title_widget.dart';

class CheckoutAddress extends StatelessWidget {
  const CheckoutAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleWidget(title: "Address"),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: ListTile(
            onTap: () {},
            leading: SvgPicture.asset(AppAssets.imagesIconsLocation,
                width: 25, height: 25),
            title: Text(
              "Your Address",
              style: AppTextStyles.style14Normal,
            ),
            subtitle: Text(
                "الحي السابع مدينة بدر الاندلس عمارة 831الدور الاول شقة 14",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.style14W600),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded, size: 16),
          ),
        ),
      ],
    );
  }
}