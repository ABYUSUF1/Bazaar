import 'package:bazaar/core/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'app_bar_desktop.dart';
import 'app_bar_mobile.dart';

class BazaarAppBar extends StatelessWidget {
  const BazaarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: AppBarMobile(),
      desktop: AppBarDesktop(),
    );
  }
}
