import 'package:bazaar/core/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImagesMobile extends StatefulWidget {
  final List<dynamic> images;
  const ProductImagesMobile({super.key, required this.images});

  @override
  State<ProductImagesMobile> createState() => _ProductImagesMobileState();
}

class _ProductImagesMobileState extends State<ProductImagesMobile> {
  int _selectedImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).width / 2,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _selectedImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => GestureDetector(
              onTap: () {
                _pageController.jumpToPage(index);
                setState(() {
                  _selectedImageIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectedImageIndex == index
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
