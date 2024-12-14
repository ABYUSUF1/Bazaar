import 'package:bazaar/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_text_styles.dart';

class NoResultFound extends StatelessWidget {
  final String lottieImage;
  final double height;
  final double width;
  final String message;
  const NoResultFound(
      {super.key,
      required this.lottieImage,
      required this.message,
      this.width = 200,
      this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(lottieImage,
            alignment: Alignment.center, width: width, height: height),
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
