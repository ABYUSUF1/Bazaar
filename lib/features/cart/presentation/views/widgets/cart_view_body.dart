import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/features/cart/presentation/manager/cart/cart_cubit.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/cart_order_summary.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/cart_products_list.dart';
import 'package:flutter/material.dart';

class CartViewBody extends StatelessWidget {
  final CartSuccess successState;
  const CartViewBody({super.key, required this.successState});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout.isDesktop(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: CartProductsList(cartProducts: successState.cartList)),
              const SizedBox(width: 10),
              Expanded(
                  child: CartOrderSummary(
                successState: successState,
              )),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartProductsList(cartProducts: successState.cartList),
              const SizedBox(height: 10),
              CartOrderSummary(successState: successState),
            ],
          );
  }
}
