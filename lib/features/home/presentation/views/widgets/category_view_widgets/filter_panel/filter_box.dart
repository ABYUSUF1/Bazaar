import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_text_styles.dart';

class FilterBox extends StatelessWidget {
  final String title;
  final Widget child;
  final bool
      isFilterApplied; // New parameter to control Clear button visibility
  final VoidCallback onClear; // New callback for clearing the filter

  const FilterBox({
    super.key,
    required this.title,
    required this.child,
    required this.isFilterApplied,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.secondaryColor, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.style20Bold,
              ),
              if (isFilterApplied) // Only show if filter is active
                TextButton(
                  onPressed: onClear,
                  child: Text(
                    'Clear',
                    style: AppTextStyles.style12Normal
                        .copyWith(color: AppColors.errorColor),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: 100,
            child: Divider(
              color: AppColors.primaryColor,
              thickness: 3,
              height: 0,
            ),
          ),
          const Divider(height: 0),
          const SizedBox(height: 20),
          child
        ],
      ),
    );
  }
}
