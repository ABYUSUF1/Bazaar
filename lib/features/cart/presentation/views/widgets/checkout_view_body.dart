import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/checkout_address.dart';
import 'package:flutter/material.dart';
import 'cart_order_summary.dart';
import 'checkout_delivery_instructions.dart';
import 'checkout_payment.dart';

class CheckoutViewBody extends StatelessWidget {
  final CartSuccess successState;
  const CheckoutViewBody({super.key, required this.successState});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.all(ResponsiveLayout.isMobile(context) ? 8.0 : 40.0),
        child: Column(
          children: [
            ///* Address
            CheckoutAddress(),
            const SizedBox(height: 30),

            ///* Delivery Instructions
            CheckoutDeliveryInstructions(),
            const SizedBox(height: 30),

            ///* Payment
            CheckoutPayment(),
            const SizedBox(height: 30),

            ///* Order Summary
            CartOrderSummary(successState: successState, showEverything: false),
          ],
        ),
      ),
    );
  }
}
