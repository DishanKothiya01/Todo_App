import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/utils/utils.dart';

// import '../data/model/auth/get_user_model.dart';
// import '../data/model/pet/pet_details_model.dart';
// import '../exports.dart';
import 'color_print.dart';

class Prefs {
  static const String currencyType = "CURRENCY-TYPE";
  static const String currencySymbol = "CURRENCY-SYMBOL";

  //? VERIFIED DETAIL DATA
  static const String accessToken = "ACCESS_TOKEN";
  static const String introComplete = "INTRO_COMPLETE";
  static const String whatsNewComplete = "WHATS_NEW_COMPLETE_1.1.3";

  //? FIREBASE DATA
  static const String socialIdSuchAsUID = "SOCIAL_ID_SUCH_AS_UID";
  static const String socialLoginType = "SOCIAL_LOGIN_TYPE";

  //? USER DATA
  static const String userModel = "USER_MODEL";
  static const String userId = "ID";
  static const String userFullName = "USER_FULL_NAME";
  static const String userGender = "USER_GENDER";
  static const String userEmail = "USER_EMAIL";
  static const String userMobile = "USER_MOBILE";
  static const String userProfile = "USER_PROFILE";
  static const String connectSplashCompleted = "CONNECT_SPLASH_COMPLETED";
  static const String newsSplashCompleted = "NEWS_SPLASH_COMPLETED";
  static const String shotsShowCaseCompleted = "SHOTS_SHOW_CASE_COMPLETED";
  static const String reminderShowCaseCompleted = "REMINDER_SHOW_CASE_COMPLETED";

  //? PRIMARY PET DATA
  static const String primaryPetModel = "PRIMARY_PET_MODEL";
  static const String primaryPetId = "PRIMARY_PET_ID";
  static const String primaryPetName = "PRIMARY_PET_NAME";

  //? PET WALKING KEYS
  static const String petWalkingId = 'PET-WALKING-ID';
  static const String startTime = 'START-TIME';
  static const String elapsedTime = 'ELAPSED-TIME';
  static const String timerType = 'TIMER-TYPE';
  static const String petsWalkData = 'PETS-WALK-DATA';
}

class DevicePrefs {
  //* =-=-=-=-=-=-=-=> Device Data <-=-=-=-=-=-=-=- //
  static const String deviceID = "DEVICE_ID";
  static const String deviceTOKEN = "DEVICE_TOKEN";
  static const String deviceTYPE = "DEVICE_TYPE";
  static const String deviceNAME = "DEVICE_NAME";

  //? INTERNAL TESTERS
  static const String internalTesters = "INTERNAL_TESTERS";

  //? ROUTE TESTERS
  static const String routeTimer = "ROUTE_TIMER";
}

class LocalStorage {
  LocalStorage._();

  static GetStorage prefs = GetStorage();
  static RxString accessToken = "".obs;

}
