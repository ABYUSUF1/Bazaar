import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class DeliveryInfo extends StatelessWidget {
  final bool showFullDetails;
  const DeliveryInfo({
    super.key,
    this.showFullDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    // Current date
    DateTime now = DateTime.now();

    // Calculate delivery dates
    DateTime standardDeliveryDate = now.add(const Duration(days: 3));
    DateTime fastestDeliveryDate = now.add(const Duration(days: 1));

    // Format dates
    String standardDeliveryFormatted =
        DateFormat('dd MMM').format(standardDeliveryDate);
    String fastestDeliveryFormatted =
        DateFormat('dd MMM').format(fastestDeliveryDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppAssets.imagesIconsFreeDelivery,
                width: 20, height: 20),
            const SizedBox(width: 5),
            Text("Free Delivery", style: AppTextStyles.style14W600),
          ],
        ),
        SizedBox(height: showFullDetails ? 20 : 5),
        Row(
          children: <Text>[
            const Text("Get it by "),
            Text(
              standardDeliveryFormatted,
              style: AppTextStyles.style14W600
                  .copyWith(color: AppColors.foregroundColor),
            )
          ],
        ),
        showFullDetails
            ? Row(
                children: <Text>[
                  const Text("Or fastest delivery"),
                  Text(" $fastestDeliveryFormatted",
                      style: AppTextStyles.style14W600),
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
