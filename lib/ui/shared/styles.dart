import 'package:flutter/material.dart';

final kTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 30.0,
    height: 1.5,
    fontWeight: FontWeight.w900);

final kSubtitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  height: 1.2,
);

final kHintTextStyle = TextStyle(
  color: Colors.white,
);

final kCardTextStyle = TextStyle(
  color: Colors.grey,
);

final kCardSubtitleTextStyle = TextStyle(
  color: Colors.grey,
);

final kNormalTextStyle = TextStyle(
  color: Colors.black,
);

final kStatusPaymentStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
);

class TextStyling extends TextStyle {
  TextStyling({
    this.color,
    this.decoration,
  });

  final Color color;
  final TextDecoration decoration;
  FontWeight fontWeight;
  double fontSize;

  huge() {
    this.fontSize = 18;
  }

  big() {
    this.fontSize = 16;
  }

  normal() {
    this.fontSize = 14;
  }

  small() {
    this.fontSize = 12;
  }

  tiny() {
    this.fontSize = 10;
  }

  bold() {
    this.fontWeight = FontWeight.bold;
  }
}
