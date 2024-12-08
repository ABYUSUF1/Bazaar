import 'package:flutter/material.dart';

customModalBottomSheet({required BuildContext context, required Widget child}) {
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity / 1.3,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          )),
        );
      });
}
