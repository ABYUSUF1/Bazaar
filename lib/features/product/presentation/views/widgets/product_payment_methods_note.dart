import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';

class ProductPaymentMethodsNote extends StatelessWidget {
  const ProductPaymentMethodsNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        _buildPaymentMethod("Pay 6 monthly payments of EGP 1,500",
            AppAssets.imagesPaymentsPaymob, context),
        const SizedBox(height: 10),
        _buildPaymentMethod("Get 5% discount when using Stripe",
            AppAssets.imagesPaymentsStripe, context),
      ],
    );
  }

  Container _buildPaymentMethod(
      String paymentMethod, String paymentImage, BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment
                  .centerLeft, // Ensures the image is on the center-left
              child: SvgPicture.asset(
                paymentImage,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                paymentMethod,
                style: AppTextStyles.style14Normal,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
