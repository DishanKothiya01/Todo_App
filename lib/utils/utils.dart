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
        UiUtils.toast('AppStrings.noInternetAvailable');
        isLoader?.value = false;
      }
      return false;
    }
  } on PlatformException catch (e) {
    printErrors(type: "getConnectivityResult Function", errText: e);
    UiUtils.toast('AppStrings.noInternetAvailable');
    isLoader?.value = false;
    return false;
  }
}

// Future<void> launchUrlFunction(url, {String? errorMess}) async {
//   try {
//     if (!await launchUrl(Uri.parse(url), mode: Platform.isIOS ? LaunchMode.externalApplication : LaunchMode.externalNonBrowserApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   } catch (e) {
//     if (!isValEmpty(errorMess)) {
//       // SnackbarHelper.showOnChangeStatus(title: errorMess, snackbarType: SnackbarType.wrong);
//     }
//     printWarning("launchUrl Function");
//   }
// }

// Future<void> makePhoneCall(String phoneNumber) async {
//   final Uri launchUri = Uri(
//     scheme: 'tel',
//     path: "${AppStrings.indianCountryCode}$phoneNumber",
//   );
//   await launchUrl(launchUri);
// }

// void copyToClipboard(BuildContext context, {required String textToCopy}) {
//   Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
//     ApiUtils.showSnackOnAPIMess("Text copy on keyboard", snackBarType: SnackBarType.wrong, bottomSpacing: defaultPadding);
//   });
// }

// Future<String?> getClipboardData() async {
//   final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
//   if (clipboardData != null && clipboardData.text != null) {
//     return clipboardData.text!;
//   } else {
//     return null;
//   }
// }

// Future<PackageInfo> getPackageInfo() async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();

//   printData(key: "AppName", value: packageInfo.appName);
//   printData(key: "Version", value: packageInfo.version);
//   printData(key: "PackageName", value: packageInfo.packageName);

//   return packageInfo;
// }

// UnsupportedError get platformUnsupportedError => UnsupportedError("Sorry, this app is Android and iOS so it does not support another platform.");

// Future<void> deleteCacheDir() async {
//   final cacheDir = await getTemporaryDirectory();

//   if (cacheDir.existsSync()) {
//     cacheDir.deleteSync(recursive: true);
//   }
// }

extension StrExtension on String {
  static String getFirstName({required String fullName}) {
    // Split the name based on spaces
    List<String> nameParts = fullName.split(' ');

    // Check if there are multiple parts
    if (nameParts.length > 1) {
      // Extract the first name
      String firstName = nameParts[0];
      return firstName;
    } else {
      // Handle case where full name doesn't have spaces
      return fullName;
    }
  }

  static String getInitialsFromFullName(String fullName) {
    if (fullName.trim().isEmpty) return '';

    List<String> names = fullName.trim().split(' ');

    String firstInitial = names.isNotEmpty && names[0].isNotEmpty ? names[0][0].toUpperCase() : '';

    String lastInitial = names.length > 1 && names[1].isNotEmpty ? names[1][0].toUpperCase() : names[0][0].toUpperCase();

    return '$firstInitial$lastInitial';
  }

  static String getInitialFromFirstName(String firstName) {
    if (firstName.trim().isEmpty) return '';

    List<String> names = firstName.trim().split(' ');
    return names[0].isNotEmpty ? names[0][0].toUpperCase() : '';
  }

  static String getLastName({required String fullName}) {
    // Split the name based on spaces
    List<String> nameParts = fullName.split(' ');

    // Check if there are multiple parts
    if (nameParts.length > 1) {
      // Extract the last name
      return nameParts.last;
    } else {
      return ""; // Return empty string if last name doesn't exist
    }
  }

  static String getFullName(String firstName, String lastName) => "$firstName $lastName";

  static String formatFirstLastName({required String name}) {
    final format = name.split(" ").map((e) => e.isNotEmpty ? e[0] : "").take(1).join().toUpperCase();
    return format;
  }

  static String formatTime(int totalMinutes, {bool sortForm = false}) {
    int hours = totalMinutes ~/ 60; // Getting total hours
    int minutes = totalMinutes % 60; // Getting remaining minutes

    // Formatting the time into a string representation
    if (sortForm) {
      return '${hours >= 1 ? '${hours}h' : ''} $minutes min${minutes != 1 ? 's' : ''}';
    } else {
      return '$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}';
    }
  }

  static String camelCaseToSnakeCase(String input) {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (char.toUpperCase() == char) {
        if (i > 0) {
          result.write('_');
        }
        result.write(char.toLowerCase());
      } else {
        result.write(char);
      }
    }
    return result.toString();
  }

  // String capitalizeFirstLetter() {
  //   if (isEmpty) {
  //     return this;
  //   }
  //   return substring(0, 1).toUpperCase() + substring(1);
  // }

  // static String dateChecker(DateTime dateTime, {String? pattern, bool onlyToday = false}) {
  //   DateTime date = dateTime.toLocal();
  //   final DateTime now = DateTime.now().toLocal();
  //   final DateTime today = DateTime(now.year, now.month, now.day);
  //   final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
  //   final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  //   if (date.year == today.year && date.month == today.month && date.day == today.day) {
  //     return 'Today';
  //   } else if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day && onlyToday == false) {
  //     return 'Tomorrow';
  //   } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day && onlyToday == false) {
  //     return 'Yesterday';
  //   } else {
  //     return Jiffy.parseFromDateTime(date).format(pattern: !isValEmpty(pattern) ? pattern : 'do MMMM yyyy');
  //   }
  // }

  // static String getSubTitle(DateTime selectedDate) {
  //   final DateTime now = DateTime.now();
  //   final DateTime selected = selectedDate;
  //   final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
  //   final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  //   if (selected.year == now.year && selected.month == now.month && selected.day == now.day) {
  //     return Jiffy.parseFromDateTime(selected).format(pattern: 'EEEE, do MMM');
  //   } else if (selected.year == tomorrow.year && selected.month == tomorrow.month && selected.day == tomorrow.day) {
  //     return Jiffy.parseFromDateTime(selected).format(pattern: 'EEEE, do MMM');
  //   } else if (selected.year == yesterday.year && selected.month == yesterday.month && selected.day == yesterday.day) {
  //     return Jiffy.parseFromDateTime(selected).format(pattern: 'EEEE, do MMM');
  //   } else {
  //     return "Today";
  //   }
  // }

  // static String todayDateCheck(dateTime, {String? pattern}) {
  //   DateTime date = dateTime;
  //   final DateTime now = DateTime.now();
  //   final DateTime today = DateTime(now.year, now.month, now.day);

  //   if (date.year == today.year && date.month == today.month && date.day == today.day) {
  //     return 'Today';
  //   } else {
  //     return Jiffy.parseFromDateTime(date).format(pattern: !isValEmpty(pattern) ? pattern : 'do MMMM yyyy');
  //   }
  // }

  /// Time Calculate --------- >>>
  // static String calculateTimeAndDate(DateTime dateTime) {
  //   DateTime now = DateTime.now();

  //   if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
  //     Duration difference = now.difference(dateTime);
  //     if (difference.inHours > 0) {
  //       return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'}';
  //     } else if (difference.inMinutes > 0) {
  //       return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'}';
  //     } else {
  //       return 'Just now';
  //     }
  //   } else {
  //     return Jiffy.parseFromDateTime(dateTime).format(pattern: 'MMM d');
  //   }
  // }

  // static String getRelativeTime(String apiDate) {
  //   DateTime dateTime = DateTime.parse(apiDate).toLocal();
  //   DateTime now = DateTime.now();
  //   Duration difference = now.difference(dateTime);

  //   if (difference.inSeconds < 60) {
  //     return 'a few moments ago';
  //   } else if (difference.inMinutes < 60) {
  //     return '${difference.inMinutes}m ago';
  //   } else if (difference.inHours < 24) {
  //     return '${difference.inHours}h ago';
  //   } else if (difference.inDays < 7) {
  //     return '${difference.inDays} days ago';
  //   } else {
  //     return Jiffy.parseFromDateTime(dateTime).format(pattern: 'MMM d'); // e.g., Jan 1
  //   }
  // }

  // static String calculateAgeDateTime(DateTime birthDate) {
  //   DateTime currentDate = DateTime.now();

  //   int years = currentDate.year - birthDate.year;
  //   int months = currentDate.month - birthDate.month;
  //   int days = currentDate.day - birthDate.day;

  //   if (days < 0) {
  //     months -= 1;
  //     days += DateTime(currentDate.year, currentDate.month, 0).day;
  //   }

  //   if (months < 0) {
  //     years -= 1;
  //     months += 12;
  //   }

  //   if (years > 0) {
  //     return '$years Year${years > 1 ? 's' : ''} Old';
  //   } else if (months > 0) {
  //     return '$months Month${months > 1 ? 's' : ''} Old';
  //   } else {
  //     return '$days Day${days > 1 ? 's' : ''} Old';
  //   }
  // }

  /// Birth Date Calculate --------- >>>
  // static String calculateAge({int? year = 0, int? month = 0, int? date = 0}) {
  //   if (year == 0 && month == 0 && date == 0 || year == null && month == null && date == null) {
  //     return '';
  //   }

  //   // Birth date
  //   DateTime birthDate = DateTime(year ?? 0, month ?? 0, date ?? 0);

  //   // Current date
  //   DateTime currentDate = DateTime.now();

  //   // Check if birth date is in the future
  //   if (birthDate.isAfter(currentDate)) {
  //     return '';
  //     // return 'Birth date is in the future';
  //   }

  //   // Calculate difference
  //   int years = currentDate.year - birthDate.year;
  //   int months = currentDate.month - birthDate.month;
  //   int days = currentDate.day - birthDate.day;

  //   // Adjust for negative values
  //   if (months < 0 || (months == 0 && days < 0)) {
  //     years--;
  //     months += 12;
  //   }
  //   if (days < 0) {
  //     days += DateTime(currentDate.year, currentDate.month - 1, 0).day;
  //     months--;
  //   }

  //   // Construct the age string
  //   if (years > 0) {
  //     return '$years ${years == 1 ? 'year' : 'years'} old';
  //   } else if (months > 0) {
  //     return '$months ${months == 1 ? 'month' : 'months'} old';
  //   } else if (days == 0) {
  //     return 'Today';
  //   } else {
  //     return '$days ${days == 1 ? 'day' : 'days'} old';
  //   }
  // }

  String get removeLabel {
    if (contains("hr")) {
      return replaceAll(" hr", "");
    }

    if (contains(" min")) {
      return replaceAll(" min", "");
    }

    return trim();
  }

  String get hour => !isValEmpty(this) ? "$this hr" : "";

  String get minute => !isValEmpty(this) ? "$this min" : "";
}

ThemeMode themeMode({required String theme}) {
  ThemeMode themeMode = ThemeMode.light;
  switch (theme) {
    case 'light':
      themeMode = ThemeMode.light;
      break;
    case 'dark':
      themeMode = ThemeMode.dark;
      break;
    case 'system':
      themeMode = ThemeMode.system;
      break;
    default:
      themeMode = ThemeMode.light;
  }
  return themeMode;
}

extension ColorExtension on Color {
  Color withCtmOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

bool isValZero(num number) => number.isEqual(0);

///Phone Number Formatting
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    final trimmed = digitsOnly.length > 10 ? digitsOnly.substring(0, 10) : digitsOnly;
    final buffer = StringBuffer();

    for (int i = 0; i < trimmed.length; i++) {
      buffer.write(trimmed[i]);
      if ((i == 2 || i == 5) && i != trimmed.length - 1) {
        buffer.write('-');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

///Card Number Formatting
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
