// import '../../../../exports.dart';
// import '../../../../view/reminder/components/reminder_sheet.dart';
// import '../../../model/pet/pet_sort_model.dart';
//
// class NotificationSheetsAndDialog {
//   NotificationSheetsAndDialog._();
//
//   static Future<bool> showReminderSheets({
//     required String? reminderCategory,
//     String? title,
//     String? desecration,
//     String? reminderId,
//     List<Pet>? petList,
//   }) async {
//     if (!isValEmpty(reminderCategory) && ReminderCategory.isValidSlug(reminderCategory!)) {
//       await ReminderSheet.reminderCompleteOnTap(
//         isNotificationSheet: true,
//         category: ReminderCategory.fromSlug(reminderCategory),
//         title: title,
//         description: desecration,
//         reminderId: reminderId,
//         petList: petList,
//       );
//       return false;
//     } else {
//       return true;
//     }
//   }
// }
