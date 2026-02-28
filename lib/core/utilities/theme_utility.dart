import 'package:flutter/material.dart';

String themeImage(String imagePath, BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return imagePath.replaceAll(".png", "-dark.png");
  }
  return imagePath;
}
