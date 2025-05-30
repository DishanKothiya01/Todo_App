import 'package:get/get.dart';

import '../../utils/color_print.dart';
import '../../utils/utils.dart';
import '../api/api_function.dart';
import '../services/notification/notification_enum.dart';

class BottomSheetRepository {
  BottomSheetRepository._();

  ///* =-=-=-=-=-=-=-= GET BOTTOM SHEET DETAILS =-=-=-=-=-=-=-=->>
  static Future<void> getBottomSheetDetailsAPI({RxBool? isLoader, required NotificationType typeOfSelectionSlug}) async {
    if (await getConnectivityResult(isLoader: isLoader)) {
      try {
        isLoader?.value = true;

        return await APIFunction.getApiCall(
          apiName: 'Get Bottom Sheet Details',
          params: {
            "sheet_place": typeOfSelectionSlug.slug,
          },
        ).then(
          (response) async {
            if (response != null && response['success'] == true && response['data'] != null) {
              // final GetDynamicSheetModel dynamicSheetModel = GetDynamicSheetModel.fromJson(response);
              //
              // DynamicBottomSheet.showDynamicSheet(dynamicSheetModel.data?.bottomSheet);

              isLoader?.value = false;
            } else {
              isLoader?.value = false;
              printErrors(type: "getBottomSheetListAPI", errText: response);
            }
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "getBottomSheetListAPI", errText: e);
      }
    }
  }

  ///* =-=-=-=-=-=-=-= CHANGE BOTTOM SHEET STATUS =-=-=-=-=-=-=-=->>
  static Future<void> changeBottomSheetStatusAPI({RxBool? isLoader, required String bottomSheetId}) async {
    if (await getConnectivityResult(isLoader: isLoader)) {
      try {
        isLoader?.value = true;

        return await APIFunction.putApiCall(
          apiName: 'Bottom-sheet status $bottomSheetId'  ,
        ).then(
          (response) async {
            if (response != null && response['success'] == true) {}
            isLoader?.value = false;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "changeBottomSheetStatusAPI", errText: e);
      }
    }
  }
}

/*
{
  "_id": "66fd27c772da0d0c58d8c285",
  "image": {"file": "https://happypetstaging.s3.ap-south-1.amazonaws.com/bottomSheetImages/file_1737697452226.webp", "aspect_ratio": "1.1", "radius": 10},
  "title": {
    "text_style": {"color": "#003443", "weight": 6, "size": 22},
    "text": "Title, or the primary message to be shown."
  },
  "description": {
    "text_style": {"color": "#003443", "weight": 4, "size": 15},
    "text": "Paragraph text or the supporting text for the above message, so that the user takes action on the CTA below"
  },
  "buttons": [
    {
      "type": "filled",
      "text": "Button 1",
      "background_color": "#FF4E00",
      "text_style": {"color": "#ffffff", "weight": 4, "size": 16},
      "cta": {"type": "action", "redirect_to": "pet_diary"},
      "_id": "66fd27db72da0d0c58d8c2aa"
    },
    // {
    //   "type": "outline",
    //   "text": "Button 2",
    //   "background_color": "#FFFFFF",
    //   "text_style": {"color": "#FF4E00", "weight": 4, "size": 16},
    //   "cta": {"type": "action", "redirect_to": "pet_diary"},
    //   "_id": "66fd27db72da0d0c58d8c2aa"
    // },
    {
      "type": "none",
      "text": "Button 3",
      "background_color": "#FFFFFF",
      "text_style": {"color": "#FF4E00", "weight": 4, "size": 16},
      "cta": {"type": "action", "redirect_to": "pet_diary"},
      "_id": "66fd27db72da0d0c58d8c2aa"
    },
  ],
  "button_axis": "vertical",
  // "button_axis": "horizontal",
  "is_closable": true,
  "deletedAt": "2024-10-02T11:00:23.176Z",
  "createdAt": "2024-10-02T11:00:23.176Z",
  "updatedAt": "2024-10-02T11:00:43.657Z"
},
*/
