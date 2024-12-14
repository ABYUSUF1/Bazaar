import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../manager/cart/cart_cubit.dart';

class CartProductsCalculation extends StatelessWidget {
  final CartSuccess state;
  const CartProductsCalculation({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SubTotal
        _customText(
            title: LocaleKeys.cart_sub_total.tr(),
            value: "\$ ${state.subTotal.toStringAsFixed(2)}"),

        // Coupon discount
        _customText(
            title: LocaleKeys.cart_coupon_discount.tr(),
            value: "\$ ${state.couponDiscount.toStringAsFixed(2)}"),

        // Shipping fee
        _customText(
            title: LocaleKeys.cart_shipping_fee.tr(),
            value: LocaleKeys.common_free.tr()),

        // Total
        const SizedBox(height: 10),
        _customText(
            title: LocaleKeys.cart_total.tr(),
            value: "\$ ${state.totalPrice.toStringAsFixed(2)}"),
      ],
    );
  }

  Column _customText({required String title, required String value}) {
    bool isTitleTotal = title == LocaleKeys.cart_total.tr();

    return Column(
      children: [
        Row(children: [
          Text(
            title,
            style: isTitleTotal
                ? AppTextStyles.style26Bold
                : AppTextStyles.style16Bold
                    .copyWith(fontWeight: FontWeight.normal),
          ),
          const Spacer(),
          Text(
            value,
            style: isTitleTotal
                ? AppTextStyles.style26Bold
                : AppTextStyles.style16Bold.copyWith(
                    fontWeight: FontWeight.normal,
                    color: value.contains(RegExp(r'-|FREE|مجاني'))
                        ? AppColors.successColor
                        : AppColors.foregroundColor),
          )
        ]),
        const SizedBox(height: 10)
      ],
    );
  }
}
