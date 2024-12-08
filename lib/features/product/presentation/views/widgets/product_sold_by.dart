import 'package:bazaar/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductSoldBy extends StatelessWidget {
  const ProductSoldBy({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                child: SvgPicture.asset(AppAssets.imagesLogosLogoIcon,
                    width: 16, height: 16),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Sold by Premier',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),
          width > 1370
              ? Row(
                  children: [
                    _infoBadgeHorizontally(
                        Icons.star, '3.9', '79% Positive Ratings'),
                    const Spacer(),
                    _infoBadgeHorizontally(
                        Icons.calendar_today, '4+ Years', 'Partner Since'),
                    const Spacer(),
                    _infoBadgeHorizontally(
                        Icons.assignment_turned_in, '80%', 'Item as Described'),
                  ],
                )
              : Column(
                  children: [
                    _infoBadgeVertically(
                        Icons.star, '3.9', '79% Positive Ratings'),
                    const SizedBox(height: 15),
                    _infoBadgeVertically(
                        Icons.calendar_today, '4+ Years', 'Partner Since'),
                    const SizedBox(height: 15),
                    _infoBadgeVertically(
                        Icons.assignment_turned_in, '80%', 'Item as Described'),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _infoBadgeHorizontally(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(width: 5),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _infoBadgeVertically(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
