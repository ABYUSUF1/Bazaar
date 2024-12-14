import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/widget/add_to_cart_button.dart';
import 'package:bazaar/core/widget/custom_scaffold.dart';
import 'package:bazaar/core/widget/wishlist_button.dart';
import 'package:bazaar/core/widget/no_result_found.dart';
import 'package:bazaar/core/widget/quantity_button.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_view_desktop/product_view_body_desktop.dart';
import 'package:bazaar/features/product/presentation/views/widgets/product_view_mobile/product_view_body_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repo/product_repo.dart';
import '../manager/get_product/get_product_cubit.dart';

class ProductView extends StatelessWidget {
  final String productId;

  const ProductView({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return BlocProvider(
      create: (_) {
        final cubit = GetProductCubit(getIt<ProductRepo>());
        cubit.getProduct(productId: productId);
        return cubit;
      },
      child: BlocBuilder<GetProductCubit, GetProductState>(
        builder: (context, state) {
          Widget body;
          Widget? bottomNavigationBar;

          if (state is GetProductFailure) {
            body = const NoResultFound(
              lottieImage: AppAssets.lottiesEmptySearch,
              message: "Try Again",
            );
          } else if (state is GetProductSuccess) {
            body = width > 1180
                ? ProductViewBodyDesktop(
                    productsDetailsEntity: state.productsDetailsEntity,
                  )
                : ProductViewBodyMobile(
                    productsDetailsEntity: state.productsDetailsEntity,
                  );

            bottomNavigationBar = width > 1180
                ? null
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12.0, bottom: 24.0),
                    child: Row(
                      children: [
                        QuantityButton(
                          product: state.productsDetailsEntity.products![0],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AddToCartButton(
                            product: state.productsDetailsEntity.products![0],
                          ),
                        ),
                        const SizedBox(width: 10),
                        FavoriteButton(
                          product: state.productsDetailsEntity.products![0],
                        ),
                      ],
                    ),
                  );
          } else {
            body = SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 1.5,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return CustomScaffold(
            body: body,
            bottomNavigationBar: bottomNavigationBar,
          );
        },
      ),
    );
  }
}
