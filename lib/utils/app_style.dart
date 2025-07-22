import 'package:flutter/material.dart';

class AppStyle {
  static late double scale;

  AppStyle({required Size screenSize}) {
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;

    if (shortestSide > tabletXl) {
      scale = 1.25;
    } else if (shortestSide > tabletLg) {
      scale = 1.15;
    } else if (shortestSide > tabletSm) {
      scale = 1;
    } else if (shortestSide > phoneLg) {
      scale = 0.9; // phone
    } else {
      scale = 0.85; // small phone
    }
    debugPrint('screenSize=$screenSize, scale=$scale');
  }
}
