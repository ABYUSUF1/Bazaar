import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/models/products_details_model/product.dart';

class ProductWarrantyAndReturnPolicy extends StatelessWidget {
  final Product product;
  const ProductWarrantyAndReturnPolicy({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _productWarrantyAndDeliveryInfo(
            svgIcon: AppAssets.imagesIconsWarranty,
            title: product.warrantyInformation!),
        const SizedBox(height: 10),
        _productWarrantyAndDeliveryInfo(
            svgIcon: AppAssets.imagesIconsReturnPolicy,
            title: product.returnPolicy!),
      ],
    );
  }

  Row _productWarrantyAndDeliveryInfo(
      {required String svgIcon, required String title}) {
    return Row(
      children: [
        SvgPicture.asset(svgIcon, width: 25, height: 25),
        const SizedBox(width: 10),
        Text(title, style: AppTextStyles.style14Normal),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: Text(
            "Learn more",
            style: AppTextStyles.style14Normal
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
