import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingWidget(
      {super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: isLoading,
        child: SizedBox(width: double.infinity, height: 120, child: child));
  }
}
