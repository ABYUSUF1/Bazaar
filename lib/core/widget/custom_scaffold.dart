import 'package:bazaar/core/widget/bazaar_app_bar/bazaar_app_bar.dart';
import 'package:flutter/material.dart';

import '../utils/responsive_layout.dart';
import 'bazaar_drawer/bazaar_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  const CustomScaffold(
      {super.key, required this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BazaarDrawer(),
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.isMobile(context) ? 8.0 : 40.0,
          vertical: 10,
        ),
        child: CustomScrollView(
          slivers: <SliverToBoxAdapter>[
            const SliverToBoxAdapter(
              child: BazaarAppBar(),
            ),
            SliverToBoxAdapter(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
