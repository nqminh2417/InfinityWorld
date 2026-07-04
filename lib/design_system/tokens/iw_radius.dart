import 'package:flutter/material.dart';

class IwRadius {
  const IwRadius._();

  static const double radius4 = 4;
  static const double radius8 = 8;
  static const double radius12 = 12;
  static const double radius16 = 16;
  static const double radius20 = 20;
  static const double radius24 = 24;
  static const double radiusFull = 999;

  static BorderRadius get buttonBorderRadius {
    return BorderRadius.circular(radius12);
  }

  static BorderRadius get cardBorderRadius {
    return BorderRadius.circular(radius16);
  }

  static BorderRadius get inputBorderRadius {
    return BorderRadius.circular(radius12);
  }
}
