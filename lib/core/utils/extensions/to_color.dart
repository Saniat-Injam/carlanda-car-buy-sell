import 'package:flutter/material.dart';

extension HexColorExtension on String {
  Color toColor() {
    String hex = replaceAll("#", "");

    if (hex.length == 6) {
      hex = "FF$hex";
    }

    if (hex.length != 8) {
      throw FormatException(
        "Invalid hex color format. Must be 6 or 8 hex digits.",
      );
    }

    return Color(int.parse("0x$hex"));
  }
}
