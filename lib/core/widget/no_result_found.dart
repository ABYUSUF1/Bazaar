import 'package:bazaar/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_text_styles.dart';

class NoResultFound extends StatelessWidget {
  final String lottieImage;
  final String message;
  const NoResultFound(
      {super.key, required this.lottieImage, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Lottie.asset(lottieImage, alignment: Alignment.center),
        const SizedBox(
          height: 16,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.style16Bold
              .copyWith(color: AppColors.foregroundColor),
        ),
      ],
    );
  }
}
