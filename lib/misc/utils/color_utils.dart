import 'package:flutter/material.dart';

Color getContrastColor(Color color) {
  return color.computeLuminance() > .5 ? Colors.black : Colors.white;
}

Color? lighten(Color? color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  // checks if color is as dark as it gets
  if (color == Color(0xff000000)) return color;

  final hsl = HSLColor.fromColor(color!);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}
