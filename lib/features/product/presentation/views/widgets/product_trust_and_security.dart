import 'package:bazaar/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductTrustAndSecurity extends StatelessWidget {
  const ProductTrustAndSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _trustRow(Icons.local_shipping, 'TRUSTED SHIPPING',
            'Free shipping when you spend EGP 200 and above on express items.'),
        const SizedBox(height: 20),
        _trustRow(
            Icons.lock, 'SECURE SHOPPING', 'Your data is always protected.'),
      ],
    );
  }

  Widget _trustRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
