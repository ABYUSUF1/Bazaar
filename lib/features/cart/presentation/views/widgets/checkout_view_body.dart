import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/checkout_address.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/place_order_button.dart';
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
        child: ResponsiveLayout(
      mobile: _mobileLayout(),
      desktop: _desktopLayout(),
    ));
  }

  Padding _mobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ///* Address
          const CheckoutAddress(),
          const SizedBox(height: 30),

          ///* Delivery Instructions
          const CheckoutDeliveryInstructions(),
          const SizedBox(height: 30),

          ///* Payment
          const CheckoutPayment(),
          const SizedBox(height: 30),

          ///* Order Summary
          CartOrderSummary(successState: successState, showEverything: false),
        ],
      ),
    );
  }

  Padding _desktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///* Address
                CheckoutAddress(),
                SizedBox(height: 30),

                ///* Delivery Instructions
                CheckoutDeliveryInstructions(),
                SizedBox(height: 30),

                ///* Payment
                CheckoutPayment(),
                SizedBox(height: 30),

                ///* Order Summary
              ],
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
              child: Column(
            children: [
              CartOrderSummary(
                  successState: successState, showEverything: false),
              const SizedBox(height: 30),
              PlaceOrderButton(successState: successState)
            ],
          )),
        ],
      ),
    );
  }
}
