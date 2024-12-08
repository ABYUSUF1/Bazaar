import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/checkout_view_body.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatelessWidget {
  final CartSuccess successState;
  const CheckoutView({super.key, required this.successState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHECKOUT", style: AppTextStyles.style16Bold),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensures the column uses minimal space
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
                "Place Order",
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
                  "${successState.cartList.length} items",
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
      ),
      body: CheckoutViewBody(successState: successState),
    );
  }
}
