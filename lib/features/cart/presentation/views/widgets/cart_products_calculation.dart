import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
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
            title: "Subtotal",
            value: "\$ ${state.subTotal.toStringAsFixed(2)}"),

        // Coupon discount
        _customText(
            title: "Coupon discount",
            value: "\$ ${state.couponDiscount.toStringAsFixed(2)}"),

        // Shipping fee
        _customText(title: "Shipping fee", value: "FREE"),

        // Total
        const SizedBox(height: 10),
        _customText(
            title: "Total", value: "\$ ${state.totalPrice.toStringAsFixed(2)}"),
      ],
    );
  }

  Column _customText({required String title, required String value}) {
    bool isTitleTotal = title == "Total";

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
                    color: value.contains(RegExp(r'-|FREE'))
                        ? AppColors.successColor
                        : AppColors.foregroundColor),
          )
        ]),
        const SizedBox(height: 10)
      ],
    );
  }
}
