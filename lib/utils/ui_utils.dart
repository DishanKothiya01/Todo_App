import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils/color_print.dart';
import 'package:todo_app/utils/utils.dart';


class UiUtils {
  UiUtils._();

  static double appButtonHeight = 48.w;
  static double bottomBarHeight = 85;

  static double bottomBarHeightWithPadding(BuildContext context) => MediaQuery.of(context).padding.bottom + bottomBarHeight + defaultPadding * 1.2;

  static Future toast(message) async {
    FToast fToast = FToast();
    fToast.removeQueuedCustomToasts();
    fToast.removeCustomToast();
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }

  static SystemUiOverlayStyle systemUiOverlayStyle({
    bool? isReverse,
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Brightness? statusBarBrightness,
    Color? systemNavigationBarColor,
  }) {
    isReverse = (isReverse ?? Get.isDarkMode);
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent, // <-- SEE HERE
      statusBarIconBrightness: statusBarIconBrightness ?? (isReverse == true ? Brightness.light : Brightness.dark), //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: statusBarBrightness ?? (isReverse == true ? Brightness.dark : Brightness.light), //<-- For iOS SEE HERE (dark icons)
      systemNavigationBarColor: systemNavigationBarColor ?? Colors.transparent,
    );
  }

  static late StreamSubscription<bool> keyboardSubscription;
  static RxBool keyboardIsOpen = false.obs;

  static bool keyboardStatusListen() {
    KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      //! Log - Keyboard Visibility
      printYellow('Keyboard visibility update. Is visible: $visible');

      keyboardIsOpen.value = visible;
    });
    return keyboardIsOpen.value;
  }

  // static Widget backIcon({VoidCallback? onPressed, Color? iconColor}) => Center(
  //       child: AppIconButton(
  //         size: 48,
  //         icon: SvgPicture.asset(
  //           AppAssets.backIcon,
  //           height: 30,
  //           width: 30,
  //           color: iconColor,
  //         ),
  //         onPressed: onPressed ?? () => Get.back(),
  //       ),
  //     );

  // static Widget closeIcon({VoidCallback? onPressed, required BuildContext context}) => AppIconButton(
  //       size: 35,
  //       onPressed: onPressed ?? () => Get.back(),
  //       backgroundColor: customColors(context).textGreyLight.withAlpha(150),
  //       icon: SvgPicture.asset(
  //         AppAssets.closeIcon,
  //         height: 24,
  //         width: 24,
  //       ),
  //     );

  static Widget menuIcon() => const Icon(
        Icons.menu,
        size: 25,
      );

  static Widget actionIcon() => const Icon(
        Icons.more_vert,
        size: 25,
      );

  // static Widget imageEmptyWidget(BuildContext context, {double? height, double? width, double? radius, Color? backgroundColor}) => Container(
  //       clipBehavior: Clip.antiAlias,
  //       height: height ?? 46.h,
  //       width: width ?? 46.h,
  //       decoration: BoxDecoration(
  //         // color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0),
  //         borderRadius: BorderRadius.circular(radius ?? (defaultRadius - (10 / 2))),
  //       ),
  //       child: Center(
  //         child: SvgPicture.asset(
  //           //TODO: Set app empty logo here
  //           AppAssets.moreIcon,
  //           height: height,
  //           width: width,
  //           colorFilter: ColorFilter.mode(Theme.of(context).primaryColor.withOpacity(0.40), BlendMode.srcIn),
  //         ),
  //         // child: Icon(
  //         //   Icons.photo_size_select_actual_outlined,
  //         //   color: AppColors.getColorOnBackground(Theme.of(context).primaryColor.withOpacity(.25)),
  //         // ),
  //       ),
  //     );

  // static PinTheme defaultPinTheme({required RxBool otpError}) {
  //   return PinTheme(
  //     width: 55,
  //     height: 56,
  //     margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
  //     textStyle: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
  //     decoration: BoxDecoration(
  //       color: customColors(Get.context!).backgroundLight,
  //       borderRadius: BorderRadius.circular(9),
  //       border: Border.all(color: otpError.isFalse ? Theme.of(Get.context!).primaryColor.withCtmOpacity(.3) : Theme.of(Get.context!).colorScheme.error),
  //     ),
  //   );
  // }

  static EdgeInsets textfieldScrollPadding(BuildContext context, {bool? showError = false, double? extendBottom}) {
    return const EdgeInsets.all(20).copyWith(bottom: (UiUtils.appButtonHeight + (defaultPadding * 3.3) + (showError != true ? defaultPadding * 1.3 : 0)) + (extendBottom ?? 0));
  }

  /// ***********************************************************************************
  ///                                 TEXT FIELD ICON
  /// ***********************************************************************************
  static Widget textFiledIcon(String svgIconPath, {double? width, double? imageHeight, RxBool? isValid}) {
    return SizedBox(
      width: width ?? 40,
      child: Center(
        key: ValueKey<RxBool?>(isValid),
        child: SvgPicture.asset(
          svgIconPath,
          height: imageHeight ?? 20,
          colorFilter: isValid?.value == false ? ColorFilter.mode(Theme.of(Get.context!).colorScheme.error, BlendMode.srcIn) : null,
        ),
      ),
    );
  }

  /// Randoms
  static String randomString = 'AaBbC cDdEeFfGg HhIiJjKkLl MmNnO oPpQqRrSsTtUuVv WwXxYyZ z1234567890 AaBbC cDdEeFfGg HhIiJjKkLl MmNnO oPpQqRrSsTtUuVv WwXxYyZ z1234567890';
  static final Random random = Random();

  static String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => randomString.codeUnitAt(
            random.nextInt(randomString.length),
          ),
        ),
      );

  /// ***********************************************************************************
  ///                               Get Address Type Svg
  /// ***********************************************************************************
  //
  // static String getAddressTypeSvg(AddressType addressType) {
  //   switch (addressType) {
  //     case AddressType.home:
  //       return AppAssets.homeIcon;
  //
  //     case AddressType.work:
  //       return AppAssets.briefcaseIcon;
  //
  //     case AddressType.friendsAndFamily:
  //       return AppAssets.frndAndfamilyIcon;
  //
  //     case AddressType.others:
  //       return AppAssets.moreIcon;
  //   }
  // }

  /// ***********************************************************************************
  /// *                                    PHONE NUMBER FORMATE                         *
  /// ***********************************************************************************

  static String formatPhoneNumber(String number) {
    if (number.length != 10) return number; // basic check

    return '${number.substring(0, 3)}-${number.substring(3, 6)}-${number.substring(6)}';
  }

// Debouncing in Increase decrease date button--------- >>>
  static Timer? _debounceTimer;
  static void commonDebounce({required Future<void> Function() callback, int? debounceTime}) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(
      Duration(milliseconds: debounceTime ?? 300),
      () async {
        /// API CALL
        await callback();
      },
    );
  }
}
