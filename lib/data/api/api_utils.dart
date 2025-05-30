// import '../handler/app_environment.dart';
//
// class ApiUtils {
//   ApiUtils._();
//   // static String baseUrl({bool ignoreVersion = false, String? versionCode}) => AppEnvironment.getBaseURL(ignoreVersion: ignoreVersion);
//
//   // static int walkNotificationId = 999999;
//
//   // static Future<dynamic>? privacyPolicyNav() {
//   //   return Get.to(
//   //     () => MyWebView(title: "Privacy Policy", webURL: AppStrings.privacyPolicyLink),
//   //   );
//   // }
//   //
//   // static Future<dynamic>? termsAndConditionsNav() {
//   //   return Get.to(
//   //     () => MyWebView(title: "Terms and Conditions", webURL: AppStrings.termsAndConditionsLink),
//   //   );
//   // }
//
//   // static void showSnackOnAPIMess(String? message, {double? bottomSpacing, double? timeLimitInSeconds, SnackbarType snackbarType = SnackbarType.complete, void Function()? onComplete}) {
//   //   if (!isValEmpty(message)) {
//   //     SnackbarHelper.showOnChangeStatus(
//   //       title: message,
//   //       timeLimitInSeconds: timeLimitInSeconds,
//   //       snackbarType: snackbarType,
//   //       bottomSpacing: bottomSpacing ?? (UiUtils.appButtonHight + defaultPadding * 2),
//   //       onComplete: onComplete,
//   //     );
//   //   } else {
//   //     printErrors(type: "showSnackOnAPIMess Function", errText: "API 'message' is Val Empty");
//   //   }
//   // }
//
//   //* =-=-> After login or Social login API <-=-=- *//
//   // static Future<void> loginAndSetUserData({required UserModelData? userModelData, RxBool? isLoader}) async {
//   //   if (userModelData?.userModel?.isActive == true) {
//   //     await LocalStorage.clearLocalStorage().then(
//   //       (_) async {
//   //         await LocalStorage.storeAccessToken(assesTokEN: userModelData?.tokens?.access?.token ?? "");
//   //
//   //         await LocalStorage.setAPIPrimaryPetModel(primaryPetModEl: userModelData?.petDetails);
//   //
//   //         await LocalStorage.setAPIUserModel(userModEL: userModelData?.userModel).then(
//   //           (_) async {
//   //             if (isRegistered<BaseViewModel>()) {
//   //               final BaseViewModel baseCon = Get.find<BaseViewModel>();
//   //
//   //               baseCon.userModelData.value = userModelData ?? UserModelData();
//   //
//   //               baseCon.userModel.value = userModelData?.userModel ?? UserModel();
//   //             }
//   //             checkUserDataThenNavigation(userModelData: userModelData);
//   //             isLoader?.value = false;
//   //           },
//   //         );
//   //       },
//   //     );
//   //   } else {
//   //     ApiUtils.showSnackOnAPIMess(AppStrings.deactivateMess, snackbarType: SnackbarType.wrong);
//   //     await logoutAndCleanAllUserData();
//   //     isLoader?.value = false;
//   //   }
//   // }
//
//   //* =-=-> Check User Data and then navigation <-=-=- *//
//   // static Future<void> checkUserDataThenNavigation({required UserModelData? userModelData}) async {
//   //   Future<void> basicDetailNav(int index, {required String type}) async {
//   //     if (!isRegistered<MobileLoginViewModel>()) {
//   //       Get.offAllNamed(AppRoutes.mobileLoginView);
//   //     }
//   //
//   //     Get.offAllNamed(
//   //       AppRoutes.basicDetailView,
//   //       predicate: (route) => route.settings.name == AppRoutes.mobileLoginView,
//   //       arguments: {
//   //         "initialIndex": type == "parent" ? 0 : (type == "pet" ? 2 : 0),
//   //         "incompleteStepCount": index,
//   //       },
//   //     );
//   //
//   //     // Get.toNamed(
//   //     //   AppRoutes.basicDetailView,
//   //     //   arguments: {
//   //     //     "initialIndex": type == "parent" ? 0 : (type == "pet" ? 2 : 0),
//   //     //     "incompleteStepCount": index,
//   //     //   },
//   //     // );
//   //   }
//   //
//   //   //? Check user authorization
//   //   if (!isValEmpty(LocalStorage.accessToken.value)) {
//   //     //?
//   //     //? User registration
//   //     //?
//   //     if (isValEmpty(userModelData?.userModel?.fullname) && isValEmpty(userModelData?.userModel?.city?.id)) {
//   //       basicDetailNav(BasicDetailPageType.fullName.index, type: "parent");
//   //     }
//   //     // ?
//   //     // ? Primary Pet registration
//   //     // ?
//   //     else {
//   //       Get.offAllNamed(AppRoutes.bottombarView);
//   //     }
//   //     /* if (userModelData?.petDetails != null && !isValEmpty(userModelData?.petDetails?.id)) {
//   //       if ((userModelData?.petDetails?.pet == null) && (userModelData?.petDetails?.petName == null) && (userModelData?.petDetails?.petDob == null) && (userModelData?.petDetails?.gender == null)) {
//   //         basicDetailNav(BasicDetailPageType.aboutPet.index, type: "pet");
//   //       } else if (isValEmpty(userModelData?.petDetails?.breed?.id)) {
//   //         basicDetailNav(BasicDetailPageType.whatIsBreed.index, type: "pet");
//   //       } else {
//   //         //? After all step complete navigation
//   //         Get.offAllNamed(AppRoutes.bottombarView);
//   //       }
//   //
//   //       //? Primary Pet Image Condition
//   //       // } else if (isValEmpty(userModelData?.primaryPet?.petImage)) {
//   //       //   basicDetailNav(6, type: "pet");
//   //       // }
//   //     } else {
//   //       basicDetailNav(BasicDetailPageType.aboutPet.index, type: "pet");
//   //     } */
//   //   } else {
//   //     Get.offAllNamed(AppRoutes.mobileLoginView);
//   //   }
//   // }
//
//   //* =-=-> Splash Screen Navigation <-=-=- *//
//   // static Future<void> navigate() async {
//   //   if (LocalStorage.accessToken.isNotEmpty) {
//   //     if (await getConnectivityResult()) {
//   //       await AuthRepository.existingUserVerifyAndGetAPI().then(
//   //         (returnUserModel) async {
//   //           if (returnUserModel != null) {
//   //             if (returnUserModel.userModel?.isActive == true) {
//   //               await checkUserDataThenNavigation(userModelData: returnUserModel);
//   //             } else {
//   //               UiUtils.toast(AppStrings.deactivateMess);
//   //               await logoutAndCleanAllUserData();
//   //             }
//   //           }
//   //         },
//   //       );
//   //     } else {
//   //       navToOnBoardingWithDelay(authorizedUser: true);
//   //       printErrors(type: "User login but", errText: AppStrings.noInternetAvailable);
//   //     }
//   //   } else {
//   //     navToOnBoardingWithDelay();
//   //   }
//   // }
//
//   //* =-=-> Navigation to onboarding after Delay <-=-=- *//
//   // static void navToOnBoardingWithDelay({bool authorizedUser = false}) async {
//   //   Future<void> navigate() async {
//   //     await Future.delayed(
//   //       const Duration(seconds: 1),
//   //       () {
//   //         Get.offAllNamed(LocalStorage.introComplete.isTrue ? AppRoutes.mobileLoginView : AppRoutes.introductionV2View);
//   //       },
//   //     );
//   //   }
//   //
//   //   if (authorizedUser) {
//   //     if (isRegistered<BaseViewModel>()) {
//   //       final BaseViewModel baseCon = Get.find<BaseViewModel>();
//   //
//   //       await checkUserDataThenNavigation(
//   //         userModelData: UserModelData(
//   //           petDetails: isValEmpty(baseCon.userModelData.value.petDetails?.id) ? LocalStorage.primaryPetModel.value : baseCon.userModelData.value.petDetails,
//   //           userModel: isValEmpty(baseCon.userModel.value.id) ? LocalStorage.userModel.value : baseCon.userModel.value,
//   //           tokens: Tokens(
//   //             access: Access(token: LocalStorage.accessToken.value),
//   //           ),
//   //         ),
//   //       );
//   //     } else {
//   //       navigate();
//   //     }
//   //   } else {
//   //     navigate();
//   //   }
//   // }
//
// //* =-=-=-=-=-=-> Navigation To Incomplete Step <-=-=-=-=-=-=- *//
// //   static void navToInCompleteStep(int inCompleteStep) {
// //     if (isRegistered<BaseViewModel>()) {
// //       final BaseViewModel baseCon = Get.find<BaseViewModel>();
// //       final UserModel userModel = baseCon.userModelData.value.userModel ?? UserModel();
// //       final PetDetails petModel = baseCon.userModelData.value.petDetails ?? PetDetails();
// //
// //       //? User authorization Data Prefill
// //       if (isRegistered<EnterFullNameViewModel>()) {
// //         final EnterFullNameViewModel nameCon = Get.find<EnterFullNameViewModel>();
// //
// //         if (!isValEmpty(userModel.fullname)) {
// //           nameCon.fullNameCon.value.text = (userModel.fullname!);
// //         }
// //
// //         if (!isValEmpty(userModel.city?.id)) {
// //           nameCon.selectedCityList.clear();
// //           nameCon.selectedCityList.add(userModel.city!);
// //         }
// //       }
// //
// //       /*  //? User from Data Prefill
// //       if (isRegistered<UserFromViewModel>()) {
// //         final UserFromViewModel fromCon = Get.find<UserFromViewModel>();
// //         if (!isValEmpty(userModel.city?.id)) {
// //           fromCon.selectedCityList.clear();
// //           fromCon.selectedCityList.add(userModel.city!);
// //         }
// //       } */
// //
// //       //? Primary Pet Data Prefill
// //       if (isRegistered<BasicDetailViewModel>()) {
// //         final BasicDetailViewModel basicCon = Get.find<BasicDetailViewModel>();
// //         basicCon.primaryPetModel.value = petModel;
// //       }
// //
// //       if (isRegistered<AboutPetViewModel>()) {
// //         final AboutPetViewModel aboutPetCon = Get.find<AboutPetViewModel>();
// //         aboutPetCon.nameCon.value.text = petModel.petName ?? "";
// //         aboutPetCon.selectedPetType.value = petModel.pet?.toString().capitalizeFirst ?? PetType.dog.name.capitalizeFirst ?? "";
// //         aboutPetCon.dateCon.value.text = !isValEmpty(petModel.petDob.toString()) ? Jiffy.parseFromDateTime(petModel.petDob!).format(pattern: 'dd MMM yyyy') : "";
// //         aboutPetCon.selectedGender.value = aboutPetCon.genderTypeConverter(type: petModel.gender ?? "");
// //       }
// //
// //       if (isRegistered<WhatBreedHaveYouViewModel>()) {
// //         final WhatBreedHaveYouViewModel breedCon = Get.find<WhatBreedHaveYouViewModel>();
// //         if (petModel.breed != null) {
// //           breedCon.selectedBreedList.clear();
// //           breedCon.selectedBreedList.add(
// //             BreedModel(
// //               id: petModel.breed?.id,
// //               // breedImage: petModel.breed?.breedImage,
// //               img: ImgModel(imgUrl: petModel.breed?.breedImage),
// //               breedName: petModel.breed?.breedName,
// //               slug: petModel.breed?.slug,
// //             ),
// //           );
// //         }
// //       }
// //     }
// //   }
//
//   //* =-=-=-=-=-=-> After Logout API nad Socket <-=-=-=-=-=-=- *//
//   // static Future<void> manageLogoutAndDeleteStatus({String? statusType}) async {
//   //   //?
//   //   //? if the user is authenticated then disconnect the socket and clear the session
//   //   if (!isValEmpty(LocalStorage.userId.value)) {
//   //     //?
//   //     //? If the disconnection type is empty, disconnect from the server otherwise, the logout or disconnect type will be an activity with disconnection.
//   //     if (statusType == "logout" || statusType == "delete_account") {
//   //       //*
//   //       //* =-= CLEAR LOCAL STORE AND ALL PERMANENT CONTROLLER BASE DATA =-=->>
//   //       await ApiUtils.logoutAndCleanAllUserData();
//   //     } else if (isRegistered<SocketController>()) {
//   //       Get.find<SocketController>().socket.disconnect();
//   //     }
//   //   }
//   // }
//   //
//   // static Future<void> logoutAndCleanAllUserData() async {
//   //   if (Get.currentRoute != AppRoutes.mobileLoginView) {
//   //     Get.offAllNamed(AppRoutes.mobileLoginView);
//   //   }
//   //
//   //   //* =-= DISCONNECT ALL EVENT AND SOCKET DISCONNECT =-=->>
//   //   if (Get.isRegistered<SocketController>()) {
//   //     Get.delete<SocketController>(force: true);
//   //   }
//   //
//   //   flutterLocalNotificationsPlugin.cancelAll();
//   //
//   //   deleteCacheDir();
//   //
//   //   await LocalStorage.clearLocalStorage();
//   //
//   //   printWarning("<-=-=-=-=-=-= DELETE TCM TOKEN =-=-=-=-=-=-=->");
//   //   await FirebaseMessaging.instance.deleteToken();
//   //
//   //   await LocalStorage.clearRouteTimes(restartAgain: false);
//   // }
//   //
//   // static Future<List<dio.MultipartFile>> convertImagesIntoMultipart(List<ImageModel> images) async {
//   //   /// Convert images into Multipart File
//   //   List<dio.MultipartFile> newImages = <dio.MultipartFile>[];
//   //
//   //   /// Add dynamic certificate keys
//   //   for (int i = 0; i < images.length; i++) {
//   //     if (!isValEmpty(images[i].file?.value)) {
//   //       String imagePathOrUrl = images[i].file?.value ?? '';
//   //
//   //       printOkStatus(imagePathOrUrl.split("/").last);
//   //
//   //       if (!UiUtils.isStringURL(imagePathOrUrl)) {
//   //         newImages.add(await dio.MultipartFile.fromFile(
//   //           imagePathOrUrl,
//   //           filename: imagePathOrUrl.split("/").last,
//   //         ));
//   //       }
//   //     }
//   //   }
//   //
//   //   return newImages;
//   // }
// }
//
// /*
//    // if (isRegistered<ChatViewModel>()) {
//     //   final ChatViewModel chatCon = Get.find<ChatViewModel>();
//
//     //   if (!isValEmpty(chatCon.conversationModel.id)) {
//     //     await ChatSocket.chatLeaveEmit(conversationId: chatCon.conversationModel.id ?? "");
//     //   }
//     // }
// */
class ApiUrls {
  /// ***********************************************************************************
  /// *                                    APIS                                        *
  /// ***********************************************************************************
  static final String baseUrl = "https://6836a919664e72d28e418f57.mockapi.io/api/todo";
  static final String getTodoApi = "/todos";
  static final String postTodoApi = "/todos";
  static String deleteTodoApi({required String id}) => "/todos/$id";
  static String updateTodoApi({required String id}) => "/todos/$id";
}
