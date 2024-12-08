import 'package:flutter/material.dart';

Color getColorForRating(double? rating) {
  if (rating == null || rating <= 0) {
    return Colors.grey; // No rating or zero rating
  }

  switch (rating.round()) {
    case 5:
      return Colors.green; // Excellent
    case 4:
      return Colors.lightGreen; // Good
    case 3:
      return Colors.orange; // Average
    case 2:
      return Colors.deepOrange; // Below Average
    case 1:
      return Colors.red; // Poor
    default:
      return Colors.red; // Fallback for any unexpected values
  }
}
