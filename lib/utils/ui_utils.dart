
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../res/app_colors.dart';

class UiUtils {
  UiUtils._();

  static double appButtonHeight = 48.w;
  static double bottomBarHeight = 85;
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.gradientEnd.withAlpha(80),
      colorText: AppColors.backgroundDark,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.black),
    );
  }

}
