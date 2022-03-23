import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

bool isTablet() {
  final Size size = window.physicalSize;
  final double ratio = window.devicePixelRatio;
  final double width = min(size.width / ratio, size.height / ratio);
  debugPrint(width.toString());
  return width > 600;
}
