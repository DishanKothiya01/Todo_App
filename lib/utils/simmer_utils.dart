import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';

class SimmerUtils {
  SimmerUtils._();

  static Widget shimmer({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    bool isShowSimmer = true,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isShowSimmer == true
          ? Shimmer.fromColors(
              baseColor: baseColor ?? AppColors.gradientEnd.withOpacity(1),
              highlightColor: highlightColor?.withOpacity(0.1) ?? Theme.of(Get.context!).primaryColor.withOpacity(0.2),
              child: child,
            )
          : child,
    );
  }

  static Container d({Color? color}) {
    return Container(
      height: 1,
      color: color ?? Colors.white.withOpacity(0.2),
    );
  }

  static Widget simmerContainer({double? height, double? width, double? borderRadius, Widget? child, Decoration? decoration}) => Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 50),
              color:AppColors.gradientEnd.withOpacity(0.1),
            ),
      );
}
