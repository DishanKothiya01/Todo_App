import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color_print.dart';
import 'components/notification_sheets_and_dialog.dart';
import 'notification_service.dart';

/*
  // {"notification_type": "update_kennel_banner", "type_id": "" , "clickAction": "NOTIFICATION_CLICK"}
*/

///* INCOMING NOTIFICATION TYPES
enum NotificationType {
  /// ***********************************************************************************
  /// *                                FROM USERS SELF                                  *
  /// ***********************************************************************************
  reminder(label: 'Reminder', slug: 'reminder'),

  /// ***********************************************************************************
  /// *                                FROM ADMIN TYPES                                 *
  /// ***********************************************************************************
  homeScreen(label: 'Home Screen', slug: 'home_screen'),
  petDiary(label: 'Pet Diary', slug: 'pet_diary'),
  parentProfile(label: 'Parent Profile', slug: 'parent_profile'),
  remindersSection(label: 'Reminders Section', slug: 'reminders_section'),
  walkingSection(label: 'Walking Section', slug: 'walking_section'),
  currentlyWalking(label: 'Currently Walking', slug: 'currently_walking'), //? It's local notification type not API (backend)

  mealsSection(label: 'Meals Section', slug: 'meals_section'),
  expenseSection(label: 'Expense Section', slug: 'expense_section'),
  addPet(label: 'Add Pet', slug: 'add_pet'),
  petDetails(label: 'Pet Details', slug: 'pet_details'), //! Pet id is required

  editPetProfile(label: 'Edit Pet Profile', slug: 'edit_pet_profile'), //! Pet id is required

  petShorts(label: 'Pet Shorts', slug: 'pet_sort'),
  petStore(label: 'Pet Store', slug: 'pet_store_view'),
  petGroomer(label: 'Pet Groomer', slug: 'pet_groomer_view'),
  petWalkers(label: 'Pet Walkers', slug: 'pet_walkers_view'),
  petBoarders(label: 'Pet Boarders', slug: 'pet_stays_view'),
  petTraining(label: 'Pet Training', slug: 'pet_training_view'),
  petSitters(label: 'Pet Sitters', slug: 'pet_sitters_view'),
  petParks(label: 'Pet Parks', slug: 'pet_parks_view'),
  petVets(label: 'Pet Vets', slug: 'pet_veterinary_view'),
  allExploreService(label: 'All Explore Service', slug: 'explore_all_services'),

  pausePetWalking(label: 'Pause Pet Walking', slug: 'pause_pet_walking'),

  /// ***********************************************************************************
  /// *                        FROM OTHER USERS OR PET PARENTS                          *
  /// ***********************************************************************************
  connectExplore(label: 'Connect Explore', slug: 'connect_explore'),
  connectMessages(label: 'Connect Messages', slug: 'connect_messages'),
  connectRequests(label: 'Connect Requests', slug: 'connect_requests'),
  acceptRequest(label: 'Accept Request', slug: 'accept_request'),
  petInvitation(label: 'Pet Invitation', slug: 'pet_invitation'),
  joinPetFamily(label: 'Join Pet Family', slug: 'join_pet_family'),
  sharedPetRemoved(label: 'Pet Invitation', slug: 'shared_pet_removed');

  final String label;
  final String slug;

  const NotificationType({
    required this.label,
    required this.slug,
  });

  static NotificationType fromSlug(String slug) {
    return NotificationType.values.firstWhere((e) => e.slug == slug);
  }

  static bool isValidSlug(String slug) {
    return NotificationType.values.any((e) => e.slug == slug);
  }

  /// Slug is valid to call navigation; otherwise, the navigation will not work.
  // static Future<void> fromSlugToNavigate(String slug, {Map<String, dynamic>? payload}) async {
  //   ///? Payload Log
  //   printYellow(payload);
  //
  //   //!
  //   //! Slug not found to just open app.
  //   Future<void> defaultNavigation() async {
  //     printErrors(type: "fromSlugToNavigate -> defaultNavigation", errText: 'Notification slug not found so navigate to bottom bar.');
  //   }
  //
  //   if (isValidSlug(slug)) {
  //     switch (fromSlug(slug)) {
  //       /// ***********************************************************************************
  //       /// *                                FROM USERS SELF                                  *
  //       /// ***********************************************************************************
  //
  //       /// Reminder
  //       case NotificationType.reminder:
  //         String petId = (payload?['pet_images'] != null) ? (jsonDecode(payload?['pet_images']).toList()[0]['_id']) : '';
  //
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           if (Get.currentRoute != AppRoutes.petDetailsView) {
  //             Get.toNamed(
  //               AppRoutes.petDetailsView,
  //               arguments: {
  //                 'petId': petId,
  //                 'tab_nav_to': 1,
  //               },
  //             );
  //           }
  //
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.pets);
  //         }
  //
  //         break;
  //
  //       /// ***********************************************************************************
  //       /// *                                FROM ADMIN TYPES                                 *
  //       /// ***********************************************************************************
  //
  //       /// Home Screen
  //       case NotificationType.homeScreen:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.pets);
  //         }
  //         break;
  //
  //       /// Pet Diary
  //       case NotificationType.petDiary:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.diary);
  //         }
  //         break;
  //
  //       /// Parent Profile
  //       case NotificationType.parentProfile:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.account);
  //         }
  //         break;
  //
  //       /// Reminders Section
  //       case NotificationType.remindersSection:
  //         if (Get.currentRoute != AppRoutes.reminderView) {
  //           Get.toNamed(AppRoutes.reminderView);
  //         }
  //         break;
  //
  //       /// Walking Section
  //       case NotificationType.walkingSection:
  //         /* if (Get.currentRoute != AppRoutes.petWalkingView) {
  //           Get.toNamed(AppRoutes.petWalkingView);
  //         } */
  //
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.pets);
  //         }
  //
  //         break;
  //
  //       /// Currently Walking
  //       case NotificationType.currentlyWalking:
  //         globalWalkCon.notificationNavigation();
  //
  //         break;
  //
  //       /// Meals Section
  //       case NotificationType.mealsSection:
  //         /* if (Get.currentRoute != AppRoutes.mealsView) {
  //           Get.toNamed(AppRoutes.mealsView);
  //         } */
  //
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.pets);
  //         }
  //
  //         break;
  //
  //       /// Expense Section
  //       case NotificationType.expenseSection:
  //         if (Get.currentRoute != AppRoutes.expenseView) {
  //           Get.toNamed(AppRoutes.expenseView);
  //         }
  //         break;
  //
  //       /// Add Pet
  //       case NotificationType.addPet:
  //         if (Get.currentRoute != AppRoutes.addPetView) {
  //           Get.toNamed(AppRoutes.addPetView);
  //         }
  //         break;
  //
  //       /// Pet Details
  //       case NotificationType.petDetails:
  //         if (Get.currentRoute != AppRoutes.petDetailsView) {
  //           String? petId = payload?["petId"];
  //
  //           if (!isValEmpty(petId)) {
  //             Get.toNamed(AppRoutes.petDetailsView, arguments: {'petId': petId});
  //           } else {
  //             printErrors(type: "Notification data", errText: "PetId is empty or null");
  //           }
  //         }
  //
  //         break;
  //
  //       /// Edit Pet Profile
  //       case NotificationType.editPetProfile:
  //         if (Get.currentRoute != AppRoutes.petDetailsView) {
  //           String? petId = payload?["petId"];
  //
  //           if (!isValEmpty(petId)) {
  //             if (isRegistered<BaseViewModel>()) {
  //               PetDetails? petDetails = Get.find<BaseViewModel>().userModelData.value.petList?.singleWhere((element) => element.id == petId);
  //
  //               Get.toNamed(AppRoutes.petDetailsView, arguments: {'petId': petDetails?.id});
  //             }
  //           } else {
  //             printErrors(type: "Notification data", errText: "PetId is empty or null");
  //           }
  //         }
  //         break;
  //
  //       /// Pet Shorts ( News and stories )
  //       case NotificationType.petShorts:
  //         if (Get.currentRoute != AppRoutes.petShortView) {
  //           Get.toNamed(AppRoutes.petShortView);
  //         }
  //         break;
  //
  //       /// Pause Pet Walking
  //       case NotificationType.pausePetWalking:
  //         globalWalkCon.notificationNavigation();
  //
  //         break;
  //
  //       /// ***********************************************************************************
  //       /// *                        FROM OTHER USERS OR PET PARENTS                          *
  //       /// ***********************************************************************************
  //
  //       /// Connect Explore
  //       case NotificationType.connectExplore:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.connect);
  //
  //           if (isRegistered<ConnectViewModel>()) {
  //             final ConnectViewModel connectCon = Get.find<ConnectViewModel>();
  //
  //             // Navigate to explore section
  //             await Future.delayed(
  //               Durations.short3,
  //               () async {
  //                 connectCon.tabController.animateTo(0);
  //               },
  //             );
  //           }
  //         }
  //         break;
  //
  //       /// Connect Messages
  //       case NotificationType.connectMessages:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.connect);
  //
  //           await Future.delayed(const Duration(milliseconds: 500));
  //
  //           if (isRegistered<ConnectViewModel>()) {
  //             final ConnectViewModel connectCon = Get.find<ConnectViewModel>();
  //
  //             // Navigate to message section
  //             await Future.delayed(
  //               Durations.short3,
  //               () async {
  //                 connectCon.tabController.animateTo(1);
  //               },
  //             );
  //           }
  //         }
  //         break;
  //
  //       /// Connect Requests
  //       case NotificationType.connectRequests:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.connect);
  //
  //           await Future.delayed(const Duration(milliseconds: 500));
  //
  //           if (isRegistered<ConnectViewModel>()) {
  //             final ConnectViewModel connectCon = Get.find<ConnectViewModel>();
  //
  //             // Navigate to requests section
  //             await Future.delayed(
  //               Durations.short3,
  //               () async {
  //                 connectCon.tabController.animateTo(2);
  //               },
  //             );
  //           }
  //         }
  //         break;
  //
  //       /// Accept Request
  //       case NotificationType.acceptRequest:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.connect);
  //
  //           await Future.delayed(const Duration(milliseconds: 500));
  //
  //           if (isRegistered<ConnectViewModel>()) {
  //             final ConnectViewModel connectCon = Get.find<ConnectViewModel>();
  //
  //             // Navigate to message section
  //             await Future.delayed(
  //               Durations.short3,
  //               () async {
  //                 connectCon.tabController.animateTo(1);
  //               },
  //             );
  //           }
  //         }
  //         break;
  //
  //       case NotificationType.petInvitation:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.account);
  //         }
  //         break;
  //
  //       case NotificationType.joinPetFamily:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.account);
  //         }
  //         break;
  //
  //       case NotificationType.sharedPetRemoved:
  //         if (Get.isRegistered<BottombarViewModel>()) {
  //           Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.values.first);
  //         }
  //         break;
  //       case NotificationType.petStore:
  //         Get.toNamed(AppRoutes.allPetStoreView);
  //         break;
  //
  //       case NotificationType.petGroomer:
  //         Get.toNamed(AppRoutes.petGroomingView);
  //         break;
  //
  //       case NotificationType.petWalkers:
  //         Get.toNamed(AppRoutes.petWalkersView);
  //         break;
  //
  //       case NotificationType.petBoarders:
  //         Get.toNamed(AppRoutes.petBoardersView);
  //         break;
  //
  //       case NotificationType.petTraining:
  //         Get.toNamed(AppRoutes.petTrainingView);
  //         break;
  //
  //       case NotificationType.petSitters:
  //         Get.toNamed(AppRoutes.petSittersView);
  //         break;
  //
  //       case NotificationType.petParks:
  //         Get.toNamed(AppRoutes.petParkView);
  //         break;
  //
  //       case NotificationType.petVets:
  //         Get.toNamed(AppRoutes.petVetsView);
  //         break;
  //
  //       case NotificationType.allExploreService:
  //         break;
  //     }
  //   } else {
  //     await defaultNavigation();
  //   }
  // }

  /// Slug is valid to call actions; otherwise, the action will not work.
  // static Future<void> fromSlugToAction(RemoteMessage? message, {NotificationState? state}) async {
  //   void printError() => printErrors(type: "fromSlugToAction -> action", errText: 'Notification slug not found in PAYLOAD so direct showing default notification.');
  //
  //   //!
  //   //! Slug not found to just open app.
  //   Future<void> defaultAction() async {
  //     if (Platform.isAndroid) {
  //       NotificationService.showNotification(remoteMessage: message);
  //     }
  //   }
  //
  //   /// Message not null
  //   if (message != null) {
  //     /// Check if user authentication
  //     if (!isValEmpty(LocalStorage.accessToken.value)) {
  //       printOkStatus("With authentication notification coming...");
  //       // printData(key: "Notification remote message", value: message.data);
  //
  //       String? notificationType = message.data['notification_type'];
  //
  //       //? Check if notification type not null or empty
  //       if (!isValEmpty(notificationType)) {
  //         //?
  //         //? Check if notification type is valid slug
  //         if (isValidSlug(notificationType ?? "")) {
  //           //?
  //           //? Which type of notification
  //           switch (fromSlug(notificationType ?? "")) {
  //             /// ***********************************************************************************
  //             /// *                                FROM USERS SELF                                  *
  //             /// ***********************************************************************************
  //
  //             /// Reminder
  //             case NotificationType.reminder:
  //               await defaultAction();
  //
  //               // Only reminder type to show bottom sheet and notification showing.
  //               await NotificationSheetsAndDialog.showReminderSheets(
  //                 reminderId: message.data['type_id'],
  //                 reminderCategory: message.data['type'],
  //                 title: message.notification?.title,
  //                 desecration: message.notification?.body,
  //                 petList: message.data["pet_images"] == null ? [] : List<Pet>.from(json.decode(message.data["pet_images"])!.map((x) => Pet.fromJson(x))),
  //               );
  //
  //               break;
  //
  //             /// ***********************************************************************************
  //             /// *                                FROM ADMIN TYPES                                 *
  //             /// ***********************************************************************************
  //
  //             // /// Home Screen
  //             // case NotificationType.homeScreen:
  //             //   break;
  //
  //             // /// Pet Diary
  //             // case NotificationType.petDiary:
  //             //   break;
  //
  //             // /// Parent Profile
  //             // case NotificationType.parentProfile:
  //             //   break;
  //
  //             // /// Reminders Section
  //             // case NotificationType.remindersSection:
  //             //   break;
  //
  //             /// Walking Section
  //             case NotificationType.walkingSection:
  //               await defaultAction();
  //
  //               // Update Home screen data
  //               if (Get.isRegistered<AllPetViewModel>()) {
  //                 final AllPetViewModel allPetModel = Get.find<AllPetViewModel>();
  //                 if (allPetModel.isLoader.isFalse) {
  //                   Get.find<AllPetViewModel>().getAllPetDetails(backgroundMode: true);
  //                 }
  //               }
  //               break;
  //
  //             // /// Currently Walking
  //             // case NotificationType.currentlyWalking:
  //             //   break;
  //
  //             /// Meals Section
  //             case NotificationType.mealsSection:
  //               await defaultAction();
  //
  //               // Update Home screen data
  //               if (Get.isRegistered<AllPetViewModel>()) {
  //                 Get.find<AllPetViewModel>().getAllPetDetails(backgroundMode: true);
  //               }
  //               break;
  //
  //             /// Expense Section
  //             case NotificationType.expenseSection:
  //               await defaultAction();
  //
  //               // Update Home screen data
  //               if (Get.isRegistered<AllPetViewModel>()) {
  //                 Get.find<AllPetViewModel>().getAllPetDetails(backgroundMode: true);
  //               }
  //               break;
  //
  //             // /// Add Pet
  //             // case NotificationType.addPet:
  //             //   break;
  //
  //             // /// Pet Details
  //             // case NotificationType.petDetails:
  //             //   break;
  //
  //             // /// Pet Shorts ( News and stories )
  //             // case NotificationType.petShorts:
  //             //   break;
  //
  //             /// Pet Shorts ( News and stories )
  //             case NotificationType.pausePetWalking:
  //               if (Get.isRegistered<GlobalPetWalkingTimerViewModel>()) {
  //                 final GlobalPetWalkingTimerViewModel globalWalkCon = Get.find<GlobalPetWalkingTimerViewModel>();
  //
  //                 if (Get.isRegistered<WalkInProgressViewModel>()) {
  //                   final WalkInProgressViewModel walkCon = Get.find<WalkInProgressViewModel>();
  //
  //                   PetWalkRepository.addAndUpdateWalkActivity(
  //                       timerStatus: TimerStatus.pause,
  //                       isLoader: walkCon.pauseButtonLoader,
  //                       petWalkingId: globalWalkCon.petWalkingId.value,
  //                       onSuccess: () async {
  //                         globalWalkCon.pauseWalking();
  //                         await PetWalkRepository.getLastIncompleteWalkAPI(/* isInitial: true */);
  //                       });
  //                 } else {
  //                   globalWalkCon.pauseWalking();
  //                 }
  //               }
  //
  //               await defaultAction();
  //
  //               break;
  //
  //             // /// Pet Diary
  //             // case NotificationType.petDiary:
  //             //   break;
  //
  //             /// ***********************************************************************************
  //             /// *                        FROM OTHER USERS OR PET PARENTS                          *
  //             /// ***********************************************************************************
  //
  //             // /// Connect Explore
  //             // case NotificationType.connectExplore:
  //             //   break;
  //
  //             // /// Connect Messages
  //             // case NotificationType.connectMessages:
  //             //   break;
  //
  //             // /// Connect Requests
  //             // case NotificationType.connectRequests:
  //             //   break;
  //
  //             // /// Accept Request
  //             // case NotificationType.acceptRequest:
  //             //   break;
  //
  //             /// pet_invitation
  //             case NotificationType.petInvitation:
  //               if (isBottomConRegistered) {
  //                 await defaultAction();
  //
  //                 final PetInvitationModel model = PetInvitationModel.fromJson(jsonDecode(message.data['invitation']));
  //
  //                 final int isExist = PetSharingUtils.petInvitisationList.indexWhere((p0) => p0.id == model.id && p0.updatedAt == model.updatedAt);
  //
  //                 if (isExist == -1) {
  //                   bool isAlreadyContainInPetList = baseCon.userModelData.value.petList?.map((e) => e.id ?? "").toList().contains(model.id) ?? false;
  //
  //                   if (!isAlreadyContainInPetList) {
  //                     PetSharingUtils.petInvitisationList.add(model);
  //
  //                     await PetSharingUtils.showNextInvitation(showNextInvitisation: false);
  //
  //                     /// Update pet details screen
  //                     if (Get.isRegistered<PetDetailsViewModel>()) {
  //                       final PetDetailsViewModel petDetailCon = Get.find<PetDetailsViewModel>();
  //
  //                       if (petDetailCon.petId == model.pet?.id) {
  //                         petDetailCon.getPetDetailsAPI(backgroundMode: true);
  //                       }
  //                     }
  //                   }
  //                 }
  //               }
  //               break;
  //
  //             case NotificationType.joinPetFamily:
  //               if (isBottomConRegistered) {
  //                 await defaultAction();
  //
  //                 if (message.data.containsKey('invitation')) {
  //                   final PetInvitationModel model = PetInvitationModel.fromJson(jsonDecode(message.data['invitation']));
  //                   PetSharingSheets.newFamilyMemberJoined(sheetId: model.id, invitationModel: model);
  //
  //                   /// Update pet details
  //                   if (Get.isRegistered<PetDetailsViewModel>()) {
  //                     final PetDetailsViewModel petDetailCon = Get.find<PetDetailsViewModel>();
  //
  //                     if (petDetailCon.petId == model.pet?.id) {
  //                       petDetailCon.getPetDetailsAPI(backgroundMode: true);
  //                     }
  //                   }
  //
  //                   /// Update family member list
  //                   if (Get.isRegistered<PetFamilyViewModel>()) {
  //                     final PetFamilyViewModel petFamilyCon = Get.find<PetFamilyViewModel>();
  //
  //                     if (petFamilyCon.petId.value == model.pet?.id) {
  //                       petFamilyCon.onReady();
  //                     }
  //                   }
  //
  //                   // Update Home screen data
  //                   if (Get.isRegistered<AllPetViewModel>()) {
  //                     Get.find<AllPetViewModel>().getAllPetDetails(backgroundMode: true);
  //                   }
  //                 }
  //
  //                 AuthRepository.existingUserVerifyAndGetAPI();
  //               }
  //
  //               break;
  //
  //             case NotificationType.sharedPetRemoved:
  //               if (isBottomConRegistered) {
  //                 // await defaultAction();
  //                 /* Get.back(closeOverlays: true);
  //               Get.offAllNamed(AppRoutes.bottombarView); */
  //
  //                 if (message.data.containsKey('invitation')) {
  //                   final PetInvitationModel model = PetInvitationModel.fromJson(jsonDecode(message.data['invitation']));
  //                   PetSharingSheets.petRemovedAlertSheet(petId: model.pet?.id ?? "", petImage: model.pet?.petImage ?? "", petName: model.pet?.petName ?? "");
  //                 }
  //                 if (isBaseConRegistered) {
  //                   Get.find<BottombarViewModel>().onBottomBarTap(BottombarTab.values.first);
  //                 }
  //
  //                 // Update Home screen data
  //                 if (Get.isRegistered<AllPetViewModel>()) {
  //                   Get.find<AllPetViewModel>().getAllPetDetails(backgroundMode: true);
  //                 }
  //
  //                 AuthRepository.existingUserVerifyAndGetAPI();
  //
  //                 PetSharingRepository.getPetInvitationListAPI(backgroundMode: true);
  //               }
  //               break;
  //
  //             default:
  //               await defaultAction();
  //               break;
  //           }
  //         } else {
  //           await defaultAction();
  //           printError();
  //         }
  //       } else {
  //         await defaultAction();
  //         printError();
  //       }
  //     } else {
  //       printYellow("Without authentication notification is coming...");
  //       // printData(key: "Notification remote message", value: message.data);
  //     }
  //   } else {
  //     printWarning("onMessage NULL");
  //   }
  // }
}

/*
 /// For reminder sheet testing 
 final Map<String, dynamic> map = {
      "pet_images": [
        {
          "_id": "6710b10686d254de8e3a8e86",
          "pet_name": "Happy",
          "user": "66e17be9781ff91a62df2d96",
          "pet_image": "file_1729147142711.webp",
        }
      ],
      "notification_type": "reminder",
      "type": "meals",
      "type_id": "67bedd7cd5e94ae46d06953d",
      "description": "vvt",
    };

    Future.delayed(
      const Duration(seconds: 1),
      () {
        Get.back();
        NotificationSheetsAndDialog.showReminderSheets(
          reminderId: map['type_id'],
          reminderCategory: map['type'],
          title: map['title'],
          desecration: map['description'],
          petList: map["pet_images"] == null ? [] : List<Pet>.from(map["pet_images"]!.map((x) => Pet.fromJson(x))),
        );
      },
    );

*/
