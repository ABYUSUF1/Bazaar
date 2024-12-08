import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final bool? displayViewAllButton;
  final bool? displayDirectionButtons;
  final ScrollController? scrollController;
  const TitleWidget(
      {super.key,
      required this.title,
      this.displayViewAllButton = false,
      this.scrollController,
      this.displayDirectionButtons = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: AppTextStyles.style16Bold,
          ),
          if (kIsWeb && displayDirectionButtons!) ...[
            const Spacer(),
            _DirectionButtons(scrollController)
          ] else if (displayViewAllButton!) ...[
            const Spacer(),
            const _ViewAllButton()
          ]
        ],
      ),
    );
  }
}

class _DirectionButtons extends StatelessWidget {
  final ScrollController? scrollController;
  const _DirectionButtons(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        _buildButton(
          onPressed: () {
            scrollController!.animateTo(
              scrollController!.offset -
                  MediaQuery.sizeOf(context)
                      .width, // Scroll down by the height of one item
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }, // Define actions
          icon: Icons.arrow_back_ios_new_rounded,
        ),
        const SizedBox(width: 10),
        _buildButton(
          onPressed: () {
            scrollController!.animateTo(
              scrollController!.offset +
                  MediaQuery.sizeOf(context)
                      .width, // Scroll down by the height of one item
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }, // Define actions
          icon: Icons.arrow_forward_ios_rounded,
        ),
      ],
    );
  }

  IconButton _buildButton(
      {required void Function()? onPressed, required IconData icon}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 15,
        color: AppColors.darkColor,
      ),
      style: TextButton.styleFrom(
          minimumSize: const Size(30, 30),
          backgroundColor: AppColors.foregroundColor2.withOpacity(0.3)),
    );
  }
}

class _ViewAllButton extends StatelessWidget {
  const _ViewAllButton();

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {}, // Define actions
      icon: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: AppColors.foregroundColor2,
      ),
      label: Text(
        LocaleKeys.home_view_all.tr(),
        style: AppTextStyles.style12BoldLightGrey,
      ),
    );
  }
}
