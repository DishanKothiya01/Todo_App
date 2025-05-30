import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //TODO: CHANGE WHOLE COLOR FILE BASED ON APP THEME
  /// Primary Colors
  static const Color kPrimaryColor = Color(0xFF10346E);
  static const Color secondaryColor = Color(0xFF53AFE6);

  ///
  static const Color secondaryLight = Color(0xff53AFE6);
  static const Color secondaryDark = Color(0xff3558D4);

  ///

  /// Background Colors
  static const Color backgroundLight = Color(0xffFFFFFF);
  static const Color backgroundGrey = Color(0xFFF4F4F4);

  ///
  static const Color backgroundDark = Color(0xff313131);
  static const Color dividerSecondary = Color(0xFFD2D2D2);

  /// Text Colors
  static const Color textLoginTitle = Color(0xff1C1C1C);

  ///
  static const Color textPrimaryBlack = Color(0xFF000000);
  static const Color textBlackColor = Color(0xFF494949);
  static const Color textSecondary = Color(0xffFFFFFF);

  ///
  static const Color textSecondaryBlack = Color(0xFF313233);

  ///
  static const Color textGreyDark = Color(0xFF494949);

  ///
  static const Color textGreyMedium = Color(0xFF202020);

  ///
  static const Color textGreyLight = Color(0xFFF4F4F4);

  ///
  static const Color textFieldBorder = Color(0xFFE8E8E8);
  static const Color textGreyColor = Color(0xFFA4A4A4);

  ///
  static const Color textFieldTitle = Color(0xFF777777);
  static const Color textError = Color(0xFFC03744);
  static const Color textYellowDark = Color(0xFF9C6600);

  /// Boarder Colors
  static const Color textFieldBorderColor = Color(0xFFE8E8E8);

  /// UI Component Colors
  static const Color iconBackground = Color(0xFFF3F3F3);

  ///
  static const Color divider = Color(0xFFF4F4F4);
  static const Color indicatorLight = Color(0xFFBCCCDE);

  /// Button & Indicator Colors
  static const Color buttonGreen = Color(0xFF00B716);
  static const Color yellowBackground = Color(0xFFFFF4CB);

  /// Miscellaneous Colors
  static const Color surfaceGrey = Color(0xFFF8F8F8);

  /// Gradient Colors
  static const Color gradientStart = Color(0xFF10346E);
  static const Color gradientEnd = Color(0xFF53AFE6);

  /// Status colors
  static const Color deliverColor = Color(0xFF00745D);

  /// Offer card colors
  static const Color offerCardColor = Color(0xFFADD9F2);

  /// Border Colors
  static const Color borderColor = Color(0XFF91A6C2);
  static const Color backgroundColor = Color(0XFF062036);

  ///Red Colors
  static const Color redColor = Color(0XFFB2191A);

  /// Utility Functions
  static Color getColorOnBackground(Color backgroundColor, {bool reverse = false}) {
    if (backgroundColor.computeLuminance() < 0.5) {
      return reverse ? Colors.black : Colors.white;
    } else {
      return reverse ? Colors.white : Colors.black;
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String fromColor(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
