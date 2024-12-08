import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

ScaffoldFeatureController showErrorSnackBar(
    {required BuildContext context, required String errMessage}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.errorColor,
      content: Text(
        errMessage,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    ),
  );
}

ScaffoldFeatureController showSuccessSnackBar(
    {required BuildContext context, required String sucMessage}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.successColor,
      content: Text(
        sucMessage,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    ),
  );
}
