import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_custom_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle textFieldStyle(BuildContext context) {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: customColors(context).textLoginTitle);
  }

  static TextStyle appButtonStyle(BuildContext context) {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle? loginTitleColor(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 24.0.sp,
          fontWeight: FontWeight.w700,
          color: color ?? customColors(context).textLoginTitle,
        );
  }

  static TextStyle? titleStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 24.0.sp,
          fontWeight: FontWeight.w600,
          color: color ?? customColors(context).secondaryDark,
        );
  }

  static TextStyle? mediumStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w500,
          color: color ?? customColors(context).textSecondary,
        );
  }

  static TextStyle? subtitleStyle(BuildContext context, {FontWeight? fontWeight, double? fontSize, Color? color}) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? customColors(context).textFieldTitle,
        );
    // style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
  }
}
