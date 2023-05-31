import 'package:flutter/material.dart';

@immutable
class CustomThemeColor extends ThemeExtension<CustomThemeColor> {
  const CustomThemeColor({
    required this.button,
    required this.buttonText,
  });

  final Color? button;
  final Color? buttonText;

  @override
  CustomThemeColor copyWith({Color? button, Color? buttonText}) {
    return CustomThemeColor(
      button: button ?? this.button,
      buttonText: buttonText ?? this.buttonText,
    );
  }

  @override
  CustomThemeColor lerp(CustomThemeColor? other, double t) {
    if (other is! CustomThemeColor) {
      return this;
    }
    return CustomThemeColor(
      button: Color.lerp(button, other.button, t),
      buttonText: Color.lerp(buttonText, other.buttonText, t),
    );
  }
}