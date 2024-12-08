import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:bazaar/core/widget/custom_scaffold.dart';
import 'package:bazaar/features/cart/presentation/views/widgets/checkout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/widget/no_result_found.dart';
import '../manager/cart/cart_cubit.dart';
import 'widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is CartSuccess) {
        return CustomScaffold(
          bottomNavigationBar: state.cartList.isNotEmpty
              ? ResponsiveLayout.isDesktop(context)
                  ? null
                  : CheckoutButton(successState: state)
              : null,
          body: state.cartList.isEmpty
              ? const NoResultFound(
                  lottieImage: AppAssets.lottiesEmptyCart,
                  message: "Your cart is empty",
                )
              : CartViewBody(successState: state),
        );
      }
      if (state is CartLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is CartFailure) {
        return const Text("Something went wrong");
      }
      return const SizedBox.shrink();
    });
  }
}
