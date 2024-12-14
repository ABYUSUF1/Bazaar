import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
        TitleWidget(title: LocaleKeys.cart_address.tr()),
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
              LocaleKeys.cart_your_address.tr(),
              style: AppTextStyles.style14Normal,
            ),
            subtitle: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.",
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
