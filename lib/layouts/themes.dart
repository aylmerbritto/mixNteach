import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/templates.dart';

class appTheme {
  var primaryColor = Color(0xFF5425B9);
  var secondaryColor = Color(0xFFFFFFFF);
  var surfaceColor = Color(0xFFEFF1ED);
  var contentColor = Color(0xFF000000);
  var disabledColor = Color(0xFF6A6A8B);

  TextStyle h1Style(context, colour) {
    return TextStyle(
        color: colour,
        fontSize: getWidth(context, 0.07),
        fontWeight: FontWeight.bold);
  }

  TextStyle h2Style(context) {
    return TextStyle(
        color: contentColor,
        fontSize: getWidth(context, 0.07),
        fontWeight: FontWeight.bold);
  }

  TextStyle h3Style(context, colour) {
    return TextStyle(
        color: colour,
        fontSize: getWidth(context, 0.1),
        fontWeight: FontWeight.bold);
  }

  TextStyle contentStyle(context, colour) {
    return TextStyle(
        color: colour,
        fontSize: getWidth(context, 0.1),
        fontWeight: FontWeight.bold);
  }

  TextStyle elvatedButtonStyle(context, colour) {
    return TextStyle(
        color: colour,
        fontSize: getWidth(context, 0.07),
        fontWeight: FontWeight.bold);
  }
}
