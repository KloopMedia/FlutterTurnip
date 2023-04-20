import 'package:flutter/material.dart';

class _FormFactor {
  static double desktop = 1440;
  static double tablet = 1000;
}

enum FormFactor {
  desktop,
  tablet,
  mobile,
}

extension Screen on BuildContext {
  FormFactor get formFactor {
    double deviceWidth = MediaQuery.of(this).size.width;
    if (deviceWidth > _FormFactor.desktop) return FormFactor.desktop;
    if (deviceWidth > _FormFactor.tablet) return FormFactor.tablet;
    return FormFactor.mobile;
  }
}
