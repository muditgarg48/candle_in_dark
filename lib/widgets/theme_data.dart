import 'package:flutter/material.dart';

import 'package:candle_in_dark/global_values.dart';

Color themeBgColor() {
  return isDark ? kToDark.shade600 : kToLight.shade600;
}

Color themeButtonTxtColor() {
  return isDark ? kToLight.shade900 : kToDark.shade900;
}

Color themeButtonColor() {
  return isDark ? kToDark.shade900 : kToLight.shade900;
}

Color themeTxtColor() {
  return isDark ? kToLight.shade900 : kToDark.shade900;
}

Color invertedThemeTxtColor() {
  return isDark ? kToLight.shade700 : kToDark.shade700;
}

Color themeCardColor() {
  return isDark ? kToDark.shade700 : kToLight.shade700;
}

List<Color> themeShades() {
  return isDark
      ? [kToDark.shade400, kToDark.shade900]
      : [kToLight.shade50, kToLight.shade900];
}
