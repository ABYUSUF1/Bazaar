import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFreeDeliveryRow(),
        SizedBox(height: showFullDetails ? 20 : 5),
        _buildStandardDeliveryText(standardDeliveryDate),
        if (showFullDetails) _buildFastestDeliveryText(fastestDeliveryDate),
      ],
    );
  }

  Widget _buildFreeDeliveryRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(AppAssets.imagesIconsFreeDelivery,
            width: 20, height: 20),
        const SizedBox(width: 5),
        Text(LocaleKeys.common_free_delivery.tr(),
            style: AppTextStyles.style14W600),
      ],
    );
  }

  Widget _buildStandardDeliveryText(DateTime deliveryDate) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${LocaleKeys.common_get_it_by.tr()} "),
        Text(
          _formatDate(deliveryDate),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.style14W600
              .copyWith(color: AppColors.foregroundColor),
        ),
      ],
    );
  }

  Widget _buildFastestDeliveryText(DateTime deliveryDate) {
    return Row(
      children: [
        Text(LocaleKeys.common_or_fastest_delivery.tr()),
        Text(" ${_formatDate(deliveryDate)}", style: AppTextStyles.style14W600),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }
}
