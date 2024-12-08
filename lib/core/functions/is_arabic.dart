import 'package:flutter/material.dart';

bool isArabic(BuildContext context) {
  return Directionality.of(context) == TextDirection.rtl;
}
