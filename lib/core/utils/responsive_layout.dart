import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  // This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= 1280 &&
      MediaQuery.of(context).size.width >= 800;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1280;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        // If our width is more than 1100 then we consider it a desktop
        if (size.width >= 1280) {
          return desktop;
        }
        // If width it less then 1100 and more then 800 we consider it as tablet
        else if (size.width >= 800 && tablet != null) {
          return tablet!;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
