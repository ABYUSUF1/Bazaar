import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';

class CheckoutButton extends StatelessWidget {
  final CartSuccess successState;
  const CheckoutButton({super.key, required this.successState});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(AppRouter.checkout, extra: successState),
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(LocaleKeys.cart_total.tr(),
                      style: AppTextStyles.style14Normal
                          .copyWith(color: AppColors.whiteColor)),
                  Text(
                    "\$ ${successState.totalPrice.toStringAsFixed(2)}",
                    style: AppTextStyles.style16Bold
                        .copyWith(color: AppColors.whiteColor),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(LocaleKeys.cart_checkout.tr(),
                  style: AppTextStyles.style20Bold
                      .copyWith(color: AppColors.whiteColor)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColors.foregroundColor,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
