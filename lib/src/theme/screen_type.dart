import 'package:flutter/material.dart';

class _FormFactor {
  static double extraLarge = 1200;
  static double large = 990;
  static double medium = 768;
}

enum FormFactor {
  extraLarge,
  large,
  medium,
  small,
}

extension Screen on BuildContext {
  FormFactor get formFactor {
    double deviceWidth = MediaQuery.of(this).size.width;
    if (deviceWidth > _FormFactor.extraLarge) return FormFactor.extraLarge;
    if (deviceWidth > _FormFactor.large) return FormFactor.large;
    if (deviceWidth > _FormFactor.medium) return FormFactor.medium;
    return FormFactor.small;
  }

  bool get isExtraLarge => formFactor == FormFactor.extraLarge;

  bool get isLarge => formFactor == FormFactor.large;

  bool get isMedium => formFactor == FormFactor.medium;

  bool get isSmall => formFactor == FormFactor.small;
}
