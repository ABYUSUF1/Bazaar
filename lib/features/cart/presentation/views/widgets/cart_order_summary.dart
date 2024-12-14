import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/cart_products_calculation.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/coupon_code_text_field.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../product/presentation/views/widgets/product_payment_methods_note.dart';
import 'checkout_button.dart';

class CartOrderSummary extends StatelessWidget {
  final CartSuccess successState;
  final bool showEverything;

  const CartOrderSummary({
    super.key,
    required this.successState,
    this.showEverything = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.foregroundColor2, width: .5),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.cart_order_summary.tr(),
              style: AppTextStyles.style20Bold
                  .copyWith(color: AppColors.foregroundColor),
            ),
            showEverything ? bigSummary(context) : smallSummary()
          ]),
    );
  }

  Column smallSummary() {
    return Column(
      children: [
        const SizedBox(height: 25),
        CartProductsCalculation(state: successState)
      ],
    );
  }

  Column bigSummary(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        const CouponCodeTextField(),
        const SizedBox(height: 25),
        CartProductsCalculation(state: successState),
        const Divider(),
        const ProductPaymentMethodsNote(),
        const SizedBox(height: 10),
        if (ResponsiveLayout.isDesktop(context))
          CheckoutButton(successState: successState),
      ],
    );
  }
}
