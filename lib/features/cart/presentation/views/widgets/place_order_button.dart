import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../manager/cart/cart_cubit.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({
    super.key,
    required this.successState,
  });

  final CartSuccess successState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensures the column uses minimal space
        children: [
          // Place Order Button
          Container(
            width: double.infinity,
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              LocaleKeys.cart_place_order.tr(),
              style: AppTextStyles.style16Bold
                  .copyWith(color: AppColors.whiteColor),
            ),
          ),
          const SizedBox(height: 8), // Add spacing
          // Row with product count and total price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${successState.cartList.length} ${LocaleKeys.common_item.tr()}",
                style: AppTextStyles.style14W600,
              ),
              Text(
                "\$ ${successState.totalPrice.toStringAsFixed(2)}",
                style: AppTextStyles.style14W600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
