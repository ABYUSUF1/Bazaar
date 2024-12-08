import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';

class HomeAds extends StatefulWidget {
  const HomeAds({super.key});

  @override
  State<HomeAds> createState() => _HomeAdsState();
}

class _HomeAdsState extends State<HomeAds> {
  final PageController _adsController = PageController();

  final List<String> _ads = <String>[
    AppAssets.imagesAdsBazaarAds1,
    AppAssets.imagesAdsBazaarAds2,
    AppAssets.imagesAdsBazaarAds3,
    AppAssets.imagesAdsBazaarAds4,
    AppAssets.imagesAdsBazaarAds5,
  ];

  @override
  void dispose() {
    _adsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 0.17,
      constraints: const BoxConstraints(minHeight: 120),
      child: Stack(
        children: [
          // PageView for ads
          PageView.builder(
            controller: _adsController,
            itemCount: _ads.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _ads[index],
                fit: BoxFit.fill,
              );
            },
          ),

          // Forward button (next page)
          Positioned(
            top: 0,
            bottom: 0,
            right: 8,
            child: _directionButton(
              context,
              width: width,
              icon: Icons.arrow_forward_ios_rounded,
              onPressed: () {
                _adsController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
          ),

          // Backward button (previous page)
          Positioned(
            top: 0,
            bottom: 0,
            left: 8,
            child: _directionButton(
              context,
              width: width,
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () {
                _adsController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
          ),
        ],
      ),
    );
  }

  IconButton _directionButton(BuildContext context,
      {required IconData icon,
      required void Function()? onPressed,
      required double width}) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        shape: const CircleBorder(),
        fixedSize: ResponsiveLayout.isMobile(context)
            ? const Size(25, 25)
            : const Size(40, 40),
      ),
      icon: Icon(icon),
      color: Colors.black,
      iconSize: ResponsiveLayout.isMobile(context) ? 15 : 20,
      alignment: Alignment.center,
    );
  }
}
