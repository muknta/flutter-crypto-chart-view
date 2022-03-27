import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

bool isTablet() {
  final Size size = window.physicalSize;
  final double ratio = window.devicePixelRatio;
  final double width = min(size.width / ratio, size.height / ratio);
  debugPrint(width.toString());
  return width > 600;
}

void showSnackBar(BuildContext context, {required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      backgroundColor: Colors.black54,
      content: AutoSizeText(
        title,
        textAlign: TextAlign.center,
        minFontSize: 16.0,
        maxFontSize: 20.0,
      ),
    ),
  );
}
