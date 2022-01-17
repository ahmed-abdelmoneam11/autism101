import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const K_vSpace = SizedBox(
  height: 20.0,
);
const K_hSpace = SizedBox(
  width: 20.0,
);

const K_backColor = Color(0XFFF8F9FF);
dynamic shadow = [
  BoxShadow(
      blurRadius: 20, // soften the shadow
      color: Colors.black12,
      spreadRadius: 3)
];

dynamic appBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)));

const String MainFontFamily = "Futura";

const TextStyle MostImportatnTopicsTitleStyle = TextStyle(
  fontFamily: MainFontFamily,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontSize: 21.0,
);

const TextStyle MostImportatnTopicsHeaderStyle = TextStyle(
  fontFamily: MainFontFamily,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontSize: 19.0,
);

const TextStyle MostImportatnTopicsHeaderSubStyle = TextStyle(
  fontFamily: MainFontFamily,
  fontWeight: FontWeight.w700,
  color: Colors.black,
  fontSize: 18.0,
);

const TextStyle MostImportatnTopicsContentStyle = TextStyle(
  fontFamily: MainFontFamily,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontSize: 18.0,
);

const TextStyle LinkStyle = TextStyle(
  fontFamily: MainFontFamily,
  fontWeight: FontWeight.w400,
  color: Colors.blue,
  fontSize: 18.0,
);

class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);

  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange;
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
