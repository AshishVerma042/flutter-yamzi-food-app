import 'package:flutter/material.dart';

class AppColors {
  //
  //
  Color get primaryColor => Color(0xFFFF5722);
  // Color get accentColor => Colors.yellow.shade400;
  Color get backgroundColor => Colors.grey.shade50;
  // Color get greenPrimaryColor => Color(0xFF60F437);
  // Color get yelloPrimaryColor => Color(0xFFFFD54F);

  // Backgrounds & surfaces
  Color get background => Color(0xFFF7F7F8); // previously Colors.grey.shade50 equivalent
  Color get surface => Colors.white;

  // Primary / brand
  Color get primary => Color(0xFFFF8A00); // warm orange (used for accents)
  Color get primaryVariant => Color(0xFFFFA94D); // lighter orange variant
  Color get primaryDark => Color(0xFFD95B00);

  // Buttons / actions
  Color get fab => Color(0xFFFFA726); // orangeAccent-ish
  Color get success => Color(0xFF2E7D32); // green
  Color get danger =>  Colors.redAccent.shade700;
  // red

  // Greys
  Color get greyLight => Color(0xFFEDEDED); // lighter greys for cards/shimmer
  Color get greyMedium => Color(0xFFBDBDBD);
  Color get grey => Color(0xFF9E9E9E);
  Color get  greyShadow => Color(0x22000000);

  // Text / icons
  Color get textPrimary => Colors.black87;
  Color get textMuted => Color(0xFF757575);
  Color get iconOnPrimary => Colors.white;

  // Misc
  Color get badge => Color(0xFFD32F2F);
  Color get cardShadow => Color(0x1A000000);

  // Gradient (mat finish - not shiny)
  Color get gradientStart => Color(0xFFD64545); // muted red
  Color get gradientEnd => Color(0xFFC73434); // deep red

  // Added from Thali Details Screen
  Color get orangeAccent => Colors.orangeAccent;
  Color get orange => Colors.orange;
  Color get deepOrange => Colors.deepOrange;
  Color get green => Colors.green;
  Color get red => Colors.red;
  Color get black => Colors.black;
  Color get pinkAccent => Colors.pinkAccent;
  Color get pink => Colors.pink;


  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  static Color getColor(String colorStr) {
    colorStr = colorStr.replaceAll('#', '');
    if (colorStr.length == 6) {
      colorStr = 'FF$colorStr'; // Add alpha value if not provided
    }
    return Color(int.parse(colorStr, radix: 16));
  }

  static final AppColors _appColors = AppColors._internal();
  factory AppColors() {
    return _appColors;
  }
  AppColors._internal();
}

AppColors appColors = AppColors();