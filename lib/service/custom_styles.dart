import 'package:flutter/material.dart';

TextStyle textStyle(Color color, double size, {required bool isBold}) {
  if (isBold) {
    return TextStyle(
      color: color,
      fontFamily: 'OpenSans',
      fontSize: size,
      fontWeight: FontWeight.w500,
    );
  } else {
    return TextStyle(
      color: color,
      fontFamily: 'OpenSans',
      fontSize: size,
    );
  }
}

BoxDecoration boxDecoration(
  Color col,
  double rad,
  double borWid,
  Color borCol,
) {
  return BoxDecoration(
    color: col,
    borderRadius: BorderRadius.circular(rad),
    border: Border.all(color: borCol, width: borWid),
  );
}

TextStyle textSwapState({
  required bool condition,
  required TextStyle tabNotSelected,
  required TextStyle tabSelected,
}) {
  if (condition) return tabSelected;
  return tabNotSelected;
}
