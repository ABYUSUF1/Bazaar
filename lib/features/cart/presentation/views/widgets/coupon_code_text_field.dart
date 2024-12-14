import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';

class CouponCodeTextField extends StatelessWidget {
  const CouponCodeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: context.read<CartCubit>().couponController,
            decoration: InputDecoration(
              hintText: LocaleKeys.cart_enter_coupon.tr(),
              hintStyle: const TextStyle(
                color: AppColors.greyColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _applyButton(context)
      ],
    );
  }

  TextButton _applyButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Trigger addCouponDiscount() when button is pressed
        context.read<CartCubit>().applyCoupon();

        // Optionally, you can show a snackbar or a dialog to confirm coupon application
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(100, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Text(
        LocaleKeys.common_apply.tr(),
        style: AppTextStyles.style14W600.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}
