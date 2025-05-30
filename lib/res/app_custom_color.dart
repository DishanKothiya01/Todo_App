import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  // Primary Colors
  final Color kPrimaryColor;
  final Color secondaryColor;
  final Color secondaryLight;
  final Color secondaryDark;

  // Background Colors
  final Color backgroundLight;
  final Color backgroundDark;
  final Color dividerSecondary;
  final Color backgroundGrey;

  // Text Colors
  final Color textLoginTitle;
  final Color textPrimaryBlack;
  final Color textSecondary;
  final Color textGreyDark;
  final Color textGreyMedium;
  final Color textGreyLight;
  final Color textGreyColor;
  final Color textFieldTitle;
  final Color textFieldBorder;
  final Color textError;
  final Color textYellowDark;
  final Color textBlackColor;

  // UI Component Colors
  final Color iconBackground;
  final Color divider;

  // Button & Indicator Colors
  final Color buttonGreen;
  final Color yellowBackground;

  // Miscellaneous Colors
  final Color surfaceGrey;

  // Gradient Colors
  final Color gradientStart;
  final Color gradientEnd;

  // offer card color
  final Color offerCardColor;

  final Color indicatorLight;

  /// Status colors
  final Color deliveredColor;

  ///Border Colors
  final Color borderColor;

  ///background Color
  final Color backgroundColor;
  final Color redColor;

  const CustomColors({
    required this.kPrimaryColor,
    required this.secondaryColor,
    required this.secondaryLight,
    required this.secondaryDark,
    required this.backgroundLight,
    required this.backgroundDark,
    required this.backgroundGrey,
    required this.dividerSecondary,
    required this.textLoginTitle,
    required this.textPrimaryBlack,
    required this.textSecondary,
    required this.textGreyDark,
    required this.textGreyMedium,
    required this.textGreyLight,
    required this.textFieldTitle,
    required this.textGreyColor,
    required this.textFieldBorder,
    required this.textError,
    required this.textYellowDark,
    required this.textBlackColor,
    required this.iconBackground,
    required this.divider,
    required this.buttonGreen,
    required this.yellowBackground,
    required this.surfaceGrey,
    required this.gradientStart,
    required this.gradientEnd,
    required this.offerCardColor,
    required this.indicatorLight,
    required this.deliveredColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.redColor,
  });

  @override
  CustomColors copyWith({
    Color? primaryRed,
    Color? secondaryColor,
    Color? secondaryLight,
    Color? secondaryDark,
    Color? backgroundLight,
    Color? backgroundDark,
    Color? backgroundGrey,
    Color? dividerSecondary,
    Color? textLoginTitle,
    Color? textPrimaryBlack,
    Color? textSecondaryBlack,
    Color? textGreyDark,
    Color? textGreyMedium,
    Color? textGreyLight,
    Color? textGreyColor,
    Color? textFieldTitle,
    Color? textFieldBorder,
    Color? textError,
    Color? textYellowDark,
    Color? textBlackColor,
    Color? iconBackground,
    Color? divider,
    Color? buttonGreen,
    Color? yellowBackground,
    Color? surfaceGrey,
    Color? gradientStart,
    Color? gradientEnd,
    Color? offerCardColor,
    Color? indicatorLight,
    Color? deliveredColor,
    Color? borderColor,
  }) {
    return CustomColors(
      kPrimaryColor: primaryRed ?? kPrimaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      secondaryLight: secondaryLight ?? this.secondaryLight,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      backgroundLight: backgroundLight ?? this.backgroundLight,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
      dividerSecondary: dividerSecondary ?? this.dividerSecondary,
      textLoginTitle: textLoginTitle ?? this.textLoginTitle,
      textPrimaryBlack: textPrimaryBlack ?? this.textPrimaryBlack,
      textSecondary: textSecondaryBlack ?? textSecondary,
      textGreyDark: textGreyDark ?? this.textGreyDark,
      textGreyMedium: textGreyMedium ?? this.textGreyMedium,
      textGreyLight: textGreyLight ?? this.textGreyLight,
      textGreyColor: textGreyColor ?? this.textGreyColor,
      textFieldTitle: textFieldTitle ?? this.textFieldTitle,
      textError: textError ?? this.textError,
      textYellowDark: textYellowDark ?? this.textYellowDark,
      textBlackColor: textBlackColor ?? this.textBlackColor,
      iconBackground: iconBackground ?? this.iconBackground,
      divider: divider ?? this.divider,
      buttonGreen: buttonGreen ?? this.buttonGreen,
      yellowBackground: yellowBackground ?? this.yellowBackground,
      surfaceGrey: surfaceGrey ?? this.surfaceGrey,
      textFieldBorder: textFieldBorder ?? this.textFieldBorder,
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      offerCardColor: gradientEnd ?? this.offerCardColor,
      indicatorLight: indicatorLight ?? this.indicatorLight,
      deliveredColor: deliveredColor ?? this.deliveredColor,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor,
      redColor: redColor,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other == null) return this;
    return CustomColors(
      kPrimaryColor: Color.lerp(kPrimaryColor, other.kPrimaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      secondaryLight: Color.lerp(secondaryLight, other.secondaryLight, t)!,
      secondaryDark: Color.lerp(secondaryDark, other.secondaryDark, t)!,
      backgroundLight: Color.lerp(backgroundLight, other.backgroundLight, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      backgroundGrey: Color.lerp(backgroundGrey, other.backgroundGrey, t)!,
      dividerSecondary: Color.lerp(dividerSecondary, other.dividerSecondary, t)!,
      textLoginTitle: Color.lerp(textLoginTitle, other.textLoginTitle, t)!,
      textPrimaryBlack: Color.lerp(textPrimaryBlack, other.textPrimaryBlack, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textGreyDark: Color.lerp(textGreyDark, other.textGreyDark, t)!,
      textGreyMedium: Color.lerp(textGreyMedium, other.textGreyMedium, t)!,
      textGreyLight: Color.lerp(textGreyLight, other.textGreyLight, t)!,
      textGreyColor: Color.lerp(textGreyColor, other.textGreyColor, t)!,
      textFieldTitle: Color.lerp(textFieldTitle, other.textFieldTitle, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textYellowDark: Color.lerp(textYellowDark, other.textYellowDark, t)!,
      textBlackColor: Color.lerp(textBlackColor, other.textBlackColor, t)!,
      iconBackground: Color.lerp(iconBackground, other.iconBackground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      buttonGreen: Color.lerp(buttonGreen, other.buttonGreen, t)!,
      yellowBackground: Color.lerp(yellowBackground, other.yellowBackground, t)!,
      surfaceGrey: Color.lerp(surfaceGrey, other.surfaceGrey, t)!,
      textFieldBorder: Color.lerp(textFieldBorder, other.textFieldBorder, t)!,
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
      offerCardColor: Color.lerp(offerCardColor, other.offerCardColor, t)!,
      indicatorLight: Color.lerp(indicatorLight, other.indicatorLight, t)!,
      deliveredColor: Color.lerp(deliveredColor, other.deliveredColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      redColor: Color.lerp(redColor, other.redColor, t)!,
    );
  }
}

// ✅ Use this function inside your widgets instead of a global variable
CustomColors customColors(BuildContext context) {
  return Theme.of(context).extension<CustomColors>() ??
      CustomColors(
        kPrimaryColor: Colors.blue,
        secondaryColor: Colors.blueAccent,
        // Default values to prevent null errors
        secondaryLight: Colors.black,
        secondaryDark: Colors.black26,
        backgroundLight: Colors.white,
        backgroundDark: Colors.black54,
        backgroundGrey: Colors.grey.shade100,
        dividerSecondary: Colors.grey.shade200,
        textLoginTitle: Colors.black,
        textPrimaryBlack: Colors.black,
        textSecondary: Colors.white,
        textGreyDark: Colors.grey,
        textGreyMedium: Colors.grey.shade600,
        textGreyLight: Colors.grey.shade400,
        textGreyColor: Colors.grey.shade500,
        textFieldTitle: Colors.grey.shade700,
        textError: Colors.redAccent,
        textYellowDark: Colors.amber.shade700,
        textBlackColor: Colors.black12,
        iconBackground: Colors.grey.shade300,
        divider: Colors.grey.shade400,
        buttonGreen: Colors.green,
        yellowBackground: Colors.yellow.shade100,
        surfaceGrey: Colors.grey.shade200,
        textFieldBorder: Colors.grey.shade500,
        gradientStart: Colors.blue,
        gradientEnd: Colors.lightBlue,
        offerCardColor: Colors.lightBlueAccent,
        indicatorLight: Colors.blue.shade100,
        deliveredColor: Colors.green,
        borderColor: Colors.white38,
        backgroundColor: Colors.blue,
        redColor: Colors.red,
      );
}
