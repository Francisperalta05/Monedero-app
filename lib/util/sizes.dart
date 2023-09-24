import 'package:flutter/material.dart';

class Sizes {
  final double size;
  Sizes(this.size);

  double sizes(BuildContext context) {
    final itemSize = (size / 414) * MediaQuery.of(context).size.width;
    return itemSize;
  }
}

TextStyle textos({
  required BuildContext ctn,
  double fSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  Color? color,
  String fontFamily = 'Inter',
  double? lineHeight,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: Sizes(fSize).sizes(ctn),
    fontWeight: fontWeight,
    color: color,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    height: Sizes(1.2).sizes(ctn),
    letterSpacing: letterSpacing,
  );
}
