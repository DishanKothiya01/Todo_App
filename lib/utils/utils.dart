import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils/color_print.dart';
import 'package:todo_app/utils/ui_utils.dart';

enum AppFlowType { normal, onboard }


const double defaultPadding = 16.0;
const double defaultRadius = 8.0;
const int defaultAmountLength = 12;
const Duration defaultDuration = Duration(milliseconds: 200);
const List<BoxShadow> defaultShadow = [BoxShadow(color: Colors.black12, blurRadius: 1)];

bool isRegistered<S>({RxBool? isLoader}) {
  if (Get.isRegistered<S>()) {
    return true;
  } else {
    printErrors(type: "Function 'isRegistered' in utils:", errText: "$S Controller not initialize");
    /* if (forcePut == true) {
      printData(key: "Force Putting", value: "Controller $S");
    } */
    isLoader?.value = false;
    return false;
  }
}

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null || value.isEmpty || value == "null" || value == "" || value == "NULL");
}

/// ------ To Check Internet Ability -------------------->>>
ConnectivityResult? connectivityResult;
final Connectivity connectivity = Connectivity();

Future<bool> getConnectivityResult({bool showToast = true, RxBool? isLoader}) async {
  try {
    connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      if (showToast == true) {
        // UiUtils.toast('AppStrings.noInternetAvailable');
        isLoader?.value = false;
      }
      return false;
    }
  } on PlatformException catch (e) {
    printErrors(type: "getConnectivityResult Function", errText: e);
    // UiUtils.toast('AppStrings.noInternetAvailable');
    isLoader?.value = false;
    return false;
  }
}

