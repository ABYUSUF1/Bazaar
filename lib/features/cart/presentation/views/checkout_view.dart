import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/checkout_view_body.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/place_order_button.dart';

class CheckoutView extends StatelessWidget {
  final CartSuccess successState;
  const CheckoutView({super.key, required this.successState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.cart_checkout.tr(),
            style: AppTextStyles.style16Bold),
        centerTitle: true,
      ),
      bottomNavigationBar: ResponsiveLayout.isDesktop(context)
          ? null
          : PlaceOrderButton(successState: successState),
      body: CheckoutViewBody(successState: successState),
    );
  }
}
