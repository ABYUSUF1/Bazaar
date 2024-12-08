import 'package:bazaar/core/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImagesDesktop extends StatefulWidget {
  final List<dynamic> images;
  const ProductImagesDesktop({super.key, required this.images});

  @override
  State<ProductImagesDesktop> createState() => _ProductImagesDesktopState();
}

class _ProductImagesDesktopState extends State<ProductImagesDesktop> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 500,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: widget.images[_selectedImageIndex],
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          shrinkWrap: true,
          itemCount: widget.images.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedImageIndex = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: _selectedImageIndex == index
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
